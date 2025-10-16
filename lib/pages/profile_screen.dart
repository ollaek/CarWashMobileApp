import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:glint/widgets/profile/info_row.dart';
import 'package:glint/widgets/profile/location_card.dart';
import 'package:glint/widgets/profile/car_tile_small.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with notification bell
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        'assets/icons/notifications.png',
                        width: 24,
                        height: 24,
                        color: const Color(0xFF0D4A58),
                      ),
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0D4A58),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Profile Picture Section
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: _showImagePicker,
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E8),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 2,
                          ),
                        ),
                        child: _selectedImage != null
                            ? ClipOval(
                                child: Image.file(
                                  _selectedImage!,
                                  width: 96,
                                  height: 96,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.sentiment_satisfied,
                                size: 48,
                                color: Colors.black,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _showImagePicker,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0D4A58),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // User Name
              const Center(
                child: Text(
                  'Ahmed Mohamed',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Color(0xFF0D4A58),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Contact Information Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                ),
                child: Column(
                  children: [
                    const InfoRow(
                      icon: Icons.phone,
                      label: 'Phone',
                      value: '+20123456789',
                    ),
                    const SizedBox(height: 10),
                    const InfoRow(
                      icon: Icons.email,
                      label: 'Email',
                      value: 'Email@example.com',
                    ),
                    const SizedBox(height: 10),
                    const InfoRow(
                      icon: Icons.calendar_today,
                      label: 'Joined',
                      value: '16 Sep, 2025',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Your Locations Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0EE),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFCBD0CC), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Locations',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Color(0xFF0D4A58),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const LocationCard(
                      title: 'Ahmed\'s Office',
                      address: 'Example St. 6th October',
                    ),
                    const SizedBox(height: 8),
                    const LocationCard(
                      title: 'Ahmed\'s Office',
                      address: 'Example St. 6th October',
                    ),
                  ],
                ),
              ),

              // Edit button aligned to the right below the container
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/edit-profile'),
                  child: const Text(
                    'Edit Your Info',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFFE04703),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Your Cars Section
              const Text(
                'Your Cars',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Color(0xFF0D4A58),
                ),
              ),

              const SizedBox(height: 12),

              // Horizontal car tiles with add button
              SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CarTileSmall(
                      brand: 'Renault',
                      model: 'Sandero',
                      details: 'Grey . 2451 س ن',
                      onMore: () =>
                          _showCarOptions(context, 'Renault', 'Sandero'),
                    ),
                    const SizedBox(width: 12),
                    CarTileSmall(
                      brand: 'Renault',
                      model: 'Sandero',
                      details: 'Grey . 2451 س ن',
                      onMore: () =>
                          _showCarOptions(context, 'Renault', 'Sandero'),
                    ),
                    const SizedBox(width: 12),
                    CarTileSmall(
                      brand: 'Renault',
                      model: 'Sandero',
                      details: 'Grey . 2451 س ن',
                      onMore: () =>
                          _showCarOptions(context, 'Renault', 'Sandero'),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/add-car'),
                      child: Container(
                        width: 150,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: Color(0xFF0D4A58),
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Add New Car',
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF0D4A58),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Old helpers removed; replaced by widgets

  void _showCarOptions(BuildContext context, String brand, String model) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0D4A58),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white, size: 20),
              title: const Text(
                'Edit',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to edit car screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Edit $brand $model'),
                    backgroundColor: const Color(0xFF0D4A58),
                  ),
                );
              },
            ),
            const Divider(color: Colors.white24, height: 1),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.white, size: 20),
              title: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Show delete confirmation dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Delete $brand $model'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Car card replaced by CarCard widget
}
