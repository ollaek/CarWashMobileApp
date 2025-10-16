import 'package:flutter/material.dart';
import 'package:glint/theme/app_theme.dart';

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

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
                flex: 4, // bigger portion of the screen
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      'assets/images/splash_screen_3.png',
                      fit: BoxFit
                          .contain, // ensures entire image is visible without cropping
                    ),
                  ),
                ),
              ),

              // Text content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Carwash at Your Doorstep
                      const Text(
                        'Carwash at Your\nDoorstep',
                        textAlign: TextAlign.center,
                        style: AppTheme.titleStyle,
                      ),
                      const SizedBox(height: 8),
                      // Tagline
                      const Text(
                        'Skip the hassle. we\'ll bring the carwash\nto your location, saving you time and\neffort.',
                        textAlign: TextAlign.center,
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
                              decoration: AppTheme.inactiveDotDecoration,
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
                              decoration: AppTheme.activeDotDecoration,
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
                        Navigator.pushReplacementNamed(context, '/onboarding');
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
