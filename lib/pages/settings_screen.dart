import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _locationPermission = true;

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
                  activeColor: const Color(0xFF0D4A58),
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
                  activeColor: const Color(0xFF0D4A58),
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

  Widget _buildSettingsItem({
    required String iconPath,
    required String title,
    required Widget child,
  }) {
    return Container(
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
  }
}
