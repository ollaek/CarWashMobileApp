import 'package:flutter/material.dart';
import 'package:glint/theme/app_theme.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppTheme.backgroundDecoration,
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/onboarding');
                    },
                    child: const Text('Skip', style: AppTheme.skipButtonStyle),
                  ),
                ),
              ),

              // Main illustration area
              Expanded(
                flex: 5, // bigger portion of the screen
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.asset(
                    'assets/images/splash_screen_1.png',
                    fit: BoxFit
                        .fitHeight, // fills height proportionally without cropping
                    width: double.infinity,
                  ),
                ),
              ),

              // Text content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Welcome To
                      const Text('Welcome To', style: AppTheme.subtitleStyle),
                      const SizedBox(height: 4),
                      // Glint
                      const Text('Glint', style: AppTheme.titleStyle),
                      const SizedBox(height: 4),
                      // Tagline
                      const Text(
                        'Smart services, anytime, anywhere.',
                        style: AppTheme.bodyStyle,
                      ),
                      const SizedBox(height: 20),
                      // Pagination dots
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 13,
                              height: 13,
                              decoration: AppTheme.activeDotDecoration,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 13,
                              height: 13,
                              decoration: AppTheme.inactiveDotDecoration,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 13,
                              height: 13,
                              decoration: AppTheme.inactiveDotDecoration,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Navigation button
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Center(
                  child: Container(
                    width: 74,
                    height: 74,
                    decoration: AppTheme.navigationButtonDecoration,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/splash2');
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 39.18,
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
}
