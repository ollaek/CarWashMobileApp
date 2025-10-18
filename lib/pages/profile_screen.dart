import 'package:flutter/material.dart';
import 'package:glint/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Account',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3E50),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          children: [
            // Profile Picture and User Info
            Center(
              child: Column(
                children: [
                  // Profile Picture
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFF2C3E50),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // User Name
                  const Text(
                    'Ethan Carter',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3E50),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Email
                  const Text(
                    'ethan.carter@email.com',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7F8C8D),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Edit Profile Button
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/edit-profile'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF20B2AA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Edit profile',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Menu Items
            _buildMenuItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.calendar_today,
          title: 'My Bookings',
          onTap: () => Navigator.pushNamed(context, '/bookings'),
          badge: '3',
        ),
        _buildMenuItem(
          icon: Icons.directions_car,
          title: 'My Vehicles',
          onTap: () => Navigator.pushNamed(context, '/vehicles'),
        ),
        _buildMenuItem(
          icon: Icons.location_on,
          title: 'My Locations',
          onTap: () => Navigator.pushNamed(context, '/locations'),
        ),
        _buildMenuItem(
          icon: Icons.notifications,
          title: 'Notifications',
          onTap: () => Navigator.pushNamed(context, '/notifications'),
        ),
        _buildMenuItem(
          icon: Icons.local_offer,
          title: 'Promotions',
          onTap: () => Navigator.pushNamed(context, '/promotions'),
        ),
        _buildMenuItem(
          icon: Icons.settings,
          title: 'Settings',
          onTap: () => Navigator.pushNamed(context, '/settings'),
        ),
        _buildMenuItem(
          icon: Icons.support_agent,
          title: 'Support Chat',
          onTap: () => Navigator.pushNamed(context, '/support-chat'),
        ),
        _buildMenuItem(
          icon: Icons.logout,
          title: 'Logout',
          onTap: () => _showLogoutDialog(),
          isLogout: true,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? badge,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isLogout
                        ? Colors.red.withOpacity(0.1)
                        : const Color(0xFF20B2AA).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isLogout ? Colors.red : const Color(0xFF20B2AA),
                    size: 20,
                  ),
                ),

                const SizedBox(width: 16),

                // Title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isLogout ? Colors.red : const Color(0xFF2C3E50),
                    ),
                  ),
                ),

                // Badge (if provided)
                if (badge != null) ...[
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFF20B2AA),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],

                // Navigation Arrow (except for logout)
                if (!isLogout)
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Color(0xFF7F8C8D),
                  ),
              ],
            ),
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
}
