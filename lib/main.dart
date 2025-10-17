import 'package:flutter/material.dart';
import 'package:glint/pages/splash_screen_1.dart';
import 'package:glint/pages/splash_screen_2.dart';
import 'package:glint/pages/splash_screen_3.dart';
import 'package:glint/pages/onboarding_screen.dart';
import 'package:glint/pages/signup_screen.dart';
import 'package:glint/pages/signin_screen.dart';
import 'package:glint/pages/otp_verification_screen.dart';
import 'package:glint/pages/home_screen.dart';
import 'package:glint/pages/request_screen.dart';
import 'package:glint/pages/profile_screen.dart';
import 'package:glint/pages/add_car_screen.dart';
import 'package:glint/pages/edit_profile_screen.dart';
import 'package:glint/pages/location_picker_screen.dart';
import 'package:glint/pages/settings_screen.dart';
import 'package:glint/pages/notifications_screen.dart';
import 'package:glint/pages/order_complete_screen.dart';
import 'package:glint/pages/vehicles_screen.dart';
import 'package:glint/pages/locations_screen.dart';
import 'package:glint/pages/bookings_screen.dart';
import 'package:glint/pages/booking_details_screen.dart';
import 'package:glint/pages/promotions_screen.dart';
import 'package:glint/pages/support_chat_screen.dart';
import 'package:glint/widgets/bottom_nav_bar.dart';
import 'package:glint/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glint',
      theme: AppTheme.themeData,
      home: const SplashScreen1(),
      routes: {
        '/home': (context) => const MainNavigationScreen(),
        '/splash2': (context) => const SplashScreen2(),
        '/splash3': (context) => const SplashScreen3(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/signup': (context) => const SignupScreen(),
        '/signin': (context) => const SigninScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/add-car': (context) => const AddCarScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/location-picker': (context) => const LocationPickerScreen(),
        '/otp': (context) {
          final phoneNumber =
              ModalRoute.of(context)!.settings.arguments as String? ?? '';
          return OtpVerificationScreen(phoneNumber: phoneNumber);
        },
        '/order-complete': (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>?;
          return OrderCompleteScreen.fromArguments(arguments ?? {});
        },
        '/bookings': (context) => const BookingsScreen(),
        '/booking-details': (context) {
          final booking =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>?;
          return BookingDetailsScreen(booking: booking ?? {});
        },
        '/vehicles': (context) => const VehiclesScreen(),
        '/locations': (context) => const LocationsScreen(),
        '/promotions': (context) => const PromotionsScreen(),
        '/support-chat': (context) => const SupportChatScreen(),
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const RequestScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
