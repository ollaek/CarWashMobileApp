import 'package:flutter/material.dart';
import 'package:glint/services/auth_service.dart';
import 'package:glint/services/api_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _locationPermission = true;
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0D4A58)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF0D4A58),
          ),
        ),
        centerTitle: true,
        actions: [
          // Notification bell with badge
          Stack(
            children: [
              Image.asset(
                'assets/icons/notifications.png',
                width: 24,
                height: 24,
                color: const Color(0xFFE04703),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Image.asset(
            'assets/icons/burger.png',
            width: 24,
            height: 24,
            color: const Color(0xFFE04703),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              // Push Notifications
              _buildSettingsItem(
                iconPath: 'assets/icons/notifications.png',
                title: 'Push Notifications',
                child: Switch(
                  value: _pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      _pushNotifications = value;
                    });
                  },
                  activeThumbColor: const Color(0xFF0D4A58),
                ),
              ),

              const SizedBox(height: 16),

              // Location Permission
              _buildSettingsItem(
                iconPath: 'assets/icons/map.png',
                title: 'Location Permission',
                child: Switch(
                  value: _locationPermission,
                  onChanged: (value) {
                    setState(() {
                      _locationPermission = value;
                    });
                  },
                  activeThumbColor: const Color(0xFF0D4A58),
                ),
              ),

              const SizedBox(height: 16),

              // Delete Account
              _buildSettingsItem(
                iconPath: 'assets/icons/delete_profile.png',
                title: 'Delete Account',
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE04703),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
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
              ),

              const SizedBox(height: 16),

              // Change Password
              _buildSettingsItem(
                iconPath: 'assets/icons/key.png',
                title: 'Change Password',
                onTap: _handleChangePassword,
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE04703),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Support
              _buildSettingsItem(
                iconPath: 'assets/icons/information.png',
                title: 'Support',
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE04703),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Divider
              Container(height: 1, color: const Color(0xFFE0E0E0)),

              const SizedBox(height: 16),

              // Log Out
              _buildSettingsItem(
                iconPath: 'assets/icons/logout.png',
                title: 'Log Out',
                onTap: () => _showLogoutDialog(),
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE04703),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    try {
      final authService = AuthService();
      final response = await authService.logout();

      if (response.isSuccess) {
        if (mounted) {
          // Navigate to login screen and clear the navigation stack
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/signin',
            (route) => false,
          );
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logged out successfully'),
              backgroundColor: Color(0xFF20B2AA),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.error ?? 'Logout failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        // Even if logout fails, clear local state and redirect
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/signin',
          (route) => false,
        );
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network error: ${e.toString()}'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontFamily: 'Mulish', color: Color(0xFF7F8C8D)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  color: Color(0xFF7F8C8D),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _handleLogout();
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingsItem({
    required String iconPath,
    required String title,
    required Widget child,
    VoidCallback? onTap,
  }) {
    Widget content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF0EE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                iconPath,
                width: 24,
                height: 24,
                color: Colors.orange[600],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF0D4A58),
              ),
            ),
          ),
          child,
        ],
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: content,
        ),
      );
    }

    return content;
  }

  Future<void> _handleChangePassword() async {
    // Show confirmation dialog
    final bool? shouldProceed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Change Password',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Color(0xFF0D4A58),
            ),
          ),
          content: const Text(
            'We will send a verification code to your email address. You will need to verify the code before setting a new password.',
            style: TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xFF666666),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D4A58),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldProceed == true) {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: Color(0xFF0D4A58),
                  strokeWidth: 2,
                ),
                SizedBox(width: 16),
                Text(
                  'Sending OTP...',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFF0D4A58),
                  ),
                ),
              ],
            ),
          );
        },
      );

      try {
        final response = await _apiService.requestPasswordChange();

        // Close loading dialog
        Navigator.of(context).pop();

        if (response.isSuccess) {
          // Navigate to OTP verification screen
          Navigator.pushNamed(context, '/change-password-otp');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.error ?? 'Failed to send OTP'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Close loading dialog
        Navigator.of(context).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
