import 'package:flutter/material.dart';
import 'package:glint/theme/app_theme.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.backgroundDecoration,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                size: 80,
                color: AppTheme.primaryColor,
              ),
              SizedBox(height: 16),
              Text('Request Screen', style: AppTheme.titleStyle),
              SizedBox(height: 8),
              Text(
                'Create new car wash requests here',
                style: AppTheme.bodyStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



