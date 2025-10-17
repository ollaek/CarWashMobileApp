import 'package:flutter/material.dart';

class OrderCompleteScreen extends StatelessWidget {
  final String serviceName;
  final String date;
  final String time;
  final String location;
  final String price;

  const OrderCompleteScreen({
    super.key,
    this.serviceName = 'Premium Wash',
    this.date = 'July 22, 2024',
    this.time = '2:00 PM',
    this.location = '123 Main St, Anytown',
    this.price = '800 LE',
  });

  factory OrderCompleteScreen.fromArguments(Map<String, dynamic> arguments) {
    return OrderCompleteScreen(
      serviceName: arguments['serviceName'] ?? 'Premium Wash',
      date: arguments['date'] ?? 'July 22, 2024',
      time: arguments['time'] ?? '2:00 PM',
      location: arguments['location'] ?? '123 Main St, Anytown',
      price: arguments['price'] ?? '800 LE',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Confirmation Icon
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFF20B2AA), // Teal color
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 60),
              ),

              const SizedBox(height: 32),

              // Main Title
              const Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3E50),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtitle
              const Text(
                'Your car cleaning service has been successfully booked. We\'ll see you soon!',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF7F8C8D),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Booking Details Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Details',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3E50),
                      ),
                    ),

                    const SizedBox(height: 24),

                    _buildDetailRow('Service', serviceName),
                    const SizedBox(height: 16),
                    _buildDetailRow('Date', date),
                    const SizedBox(height: 16),
                    _buildDetailRow('Time', time),
                    const SizedBox(height: 16),
                    _buildDetailRow('Location', location),
                    const SizedBox(height: 16),
                    _buildDetailRow('Price', price),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Action Buttons
              Column(
                children: [
                  // Primary Button - View My Bookings
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to bookings screen
                        Navigator.pushNamed(context, '/bookings');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF20B2AA),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'View My Bookings',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Secondary Button - Go to Home
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigate to home screen
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF20B2AA),
                        side: const BorderSide(
                          color: Color(0xFF20B2AA),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Go to Home',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Mulish',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF7F8C8D),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
