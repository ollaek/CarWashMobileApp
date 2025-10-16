import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final String title;
  final String address;

  const LocationCard({super.key, required this.title, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        // Match vector fill #EEF0EE with 10px corner radius
        color: const Color(0xFFEEF0EE),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCBD0CC), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            address,
            style: const TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}
