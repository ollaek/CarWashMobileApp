import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

              const SizedBox(height: 20),

              // Profile Picture Section
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: _showImagePicker,
                      child: Container(
                        width: 120,
                        height: 120,
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
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.sentiment_satisfied,
                                size: 60,
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
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0D4A58),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // User Name
              const Center(
                child: Text(
                  'Ahmed Mohamed',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    color: Color(0xFF0D4A58),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Contact Information Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                ),
                child: Column(
                  children: [
                    _buildContactItem(Icons.phone, 'Phone', '+20123456789'),
                    const SizedBox(height: 16),
                    _buildContactItem(
                      Icons.email,
                      'Email',
                      'Email@example.com',
                    ),
                    const SizedBox(height: 16),
                    _buildContactItem(
                      Icons.calendar_today,
                      'Joined',
                      '16 Sep, 2025',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Your Locations Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/edit-profile');
                          },
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
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildLocationItem(
                      'Ahmed\'s Office',
                      'Example St. 6th October',
                    ),
                    const Divider(color: Color(0xFFE0E0E0), height: 24),
                    _buildLocationItem(
                      'Ahmed\'s Office',
                      'Example St. 6th October',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

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

              const SizedBox(height: 16),

              // Car Cards
              _buildCarCard('Renault', 'Sandero', 'Grey . 2451 س ن'),
              const SizedBox(height: 12),
              _buildCarCard('Renault', 'Sandero', 'Grey . 2451 س ن'),
              const SizedBox(height: 12),
              _buildCarCard('Renault', 'Sandero', 'Grey . 2451 س ن'),

              const SizedBox(height: 24),

              // Add New Car Button
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/add-car'),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFE0E0E0),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Color(0xFF0D4A58), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Add New Car',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF0D4A58),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF666666), size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Color(0xFF0D4A58),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationItem(String title, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          address,
          style: const TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

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

  Widget _buildCarCard(String brand, String model, String details) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  model,
                  style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/home_car.png',
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _showCarOptions(context, brand, model),
            child: const Icon(
              Icons.more_vert,
              color: Color(0xFF666666),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
