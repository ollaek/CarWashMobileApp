import 'package:flutter/material.dart';
import 'package:glint/theme/app_theme.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppTheme.backgroundDecoration,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                // Main illustration area
                Expanded(
                  flex: 4,
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        'assets/images/onboarding_screen.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // Branding and text content
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Glint brand name
                      const Text(
                        'Glint',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w800,
                          fontSize: 48,
                          color: Color(0xFF0D4A58), // Dark teal color
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Tagline
                      const Text(
                        'Your car, our care.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          height: 1.0, // 100% line height
                          letterSpacing: 0.0, // 0% letter spacing
                          color: Color(0xFF666666), // Dark grey
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),

                // Get Started button
                Container(
                  width: double.infinity,
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B35), // Orange color
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                // Login link
                Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to login screen (you can implement this later)
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFFFF6B35), // Orange color
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
