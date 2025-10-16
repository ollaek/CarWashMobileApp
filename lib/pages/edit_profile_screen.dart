import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController(
    text: 'Ahmed Mohamed',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'Email@example.com',
  );
  final TextEditingController _countryCodeController = TextEditingController(
    text: '+20',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '123456789',
  );

  List<Map<String, dynamic>> _locations = [
    {'name': 'Ahmed\'s Office', 'address': 'Example St, 6th October'},
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _countryCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _addLocation() async {
    final result = await Navigator.pushNamed(context, '/location-picker');
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _locations.add({
          'name': result['name'],
          'address':
              'Selected Location', // You can implement reverse geocoding here
        });
      });
    }
  }

  void _removeLocation(int index) {
    setState(() {
      _locations.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0D4A58)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF0D4A58),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name Section
              _buildTextField(
                controller: _fullNameController,
                label: 'Full Name',
                hintText: 'Enter your full name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // Email Address Section
              _buildTextField(
                controller: _emailController,
                label: 'Email Address',
                hintText: 'Enter your email address',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // Phone Number Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF0D4A58),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Country Code Input
                      SizedBox(
                        width: 80,
                        child: TextFormField(
                          controller: _countryCodeController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '+20',
                            hintStyle: const TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF999999),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFB9FAF8),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFB9FAF8),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFFF6B35),
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Phone Number Input
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Enter phone number',
                            hintStyle: const TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF999999),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFB9FAF8),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFB9FAF8),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFFF6B35),
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Your Locations Section
              const Text(
                'Your Locations',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF0D4A58),
                ),
              ),
              const SizedBox(height: 16),

              // Location Cards
              ..._locations.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> location = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              location['name'],
                              style: const TextStyle(
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              location['address'],
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
                      GestureDetector(
                        onTap: () => _removeLocation(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE04703),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              const SizedBox(height: 16),

              // Add Location Button
              Row(
                children: [
                  const Icon(Icons.add, color: Color(0xFFE04703), size: 20),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: _addLocation,
                    child: const Text(
                      'Add Location',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF0D4A58),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Save Changes Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle save changes logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile updated successfully!'),
                          backgroundColor: Color(0xFF0D4A58),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE04703),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF0D4A58),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xFF999999),
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB9FAF8), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB9FAF8), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFFF6B35), width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
