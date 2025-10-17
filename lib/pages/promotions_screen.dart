import 'package:flutter/material.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F4F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Promotions',
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Available Section
            _buildSectionTitle('Available'),
            const SizedBox(height: 16),
            _buildAvailablePromotions(),

            const SizedBox(height: 32),

            // Expired Section
            _buildSectionTitle('Expired'),
            const SizedBox(height: 16),
            _buildExpiredPromotions(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2C3E50),
      ),
    );
  }

  Widget _buildAvailablePromotions() {
    final availablePromotions = [
      {
        'icon': Icons.percent,
        'offer': '20% off your first wash',
        'validity': 'Valid until Dec 31, 2024',
        'buttonText': 'Apply',
        'buttonColor': const Color(0xFFFF6B35),
        'textColor': Colors.white,
      },
      {
        'icon': Icons.car_repair,
        'offer': 'Free interior detailing',
        'validity': 'Valid until Nov 15, 2024',
        'buttonText': 'Apply',
        'buttonColor': const Color(0xFFFF6B35),
        'textColor': Colors.white,
      },
      {
        'icon': Icons.local_offer,
        'offer': '\$15 off any service',
        'validity': 'Valid until Oct 31, 2024',
        'buttonText': 'Apply',
        'buttonColor': const Color(0xFFFF6B35),
        'textColor': Colors.white,
      },
    ];

    return Column(
      children: availablePromotions.map((promotion) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: _buildPromotionCard(
            icon: promotion['icon'] as IconData,
            offer: promotion['offer'] as String,
            validity: promotion['validity'] as String,
            buttonText: promotion['buttonText'] as String,
            buttonColor: promotion['buttonColor'] as Color,
            textColor: promotion['textColor'] as Color,
            isExpired: false,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExpiredPromotions() {
    final expiredPromotions = [
      {
        'icon': Icons.refresh,
        'offer': 'Summer Special: 10% off',
        'validity': 'Expired on Sep 30, 2024',
        'buttonText': 'Expired',
        'buttonColor': const Color(0xFFE0E0E0),
        'textColor': const Color(0xFF666666),
      },
    ];

    return Column(
      children: expiredPromotions.map((promotion) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: _buildPromotionCard(
            icon: promotion['icon'] as IconData,
            offer: promotion['offer'] as String,
            validity: promotion['validity'] as String,
            buttonText: promotion['buttonText'] as String,
            buttonColor: promotion['buttonColor'] as Color,
            textColor: promotion['textColor'] as Color,
            isExpired: true,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPromotionCard({
    required IconData icon,
    required String offer,
    required String validity,
    required String buttonText,
    required Color buttonColor,
    required Color textColor,
    required bool isExpired,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isExpired
                  ? const Color(0xFFF5F5F5)
                  : const Color(0xFFFFF3E0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isExpired
                  ? const Color(0xFF666666)
                  : const Color(0xFFFF6B35),
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          // Offer Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isExpired
                        ? const Color(0xFF2C3E50)
                        : const Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  validity,
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isExpired
                        ? const Color(0xFF999999)
                        : const Color(0xFF7F8C8D),
                  ),
                ),
              ],
            ),
          ),

          // Action Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
