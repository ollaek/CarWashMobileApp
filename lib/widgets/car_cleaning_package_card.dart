import 'package:flutter/material.dart';

class CarCleaningPackageCard extends StatelessWidget {
  final String packageName;
  final String duration;
  final List<String> services;
  final String price;
  final bool isSelected;
  final VoidCallback? onTap;

  const CarCleaningPackageCard({
    super.key,
    required this.packageName,
    required this.duration,
    required this.services,
    required this.price,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD8F6F6) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0D4A58)
                : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Duration and Car Icon
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 16,
                  color: Color(0xFF9E9E9E),
                ),
                const SizedBox(width: 6),
                Text(
                  duration,
                  style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Car Illustration image
            Center(
              child: Image.asset(
                'assets/images/request_package.png',
                width: 50,
                height: 36,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 12),

            // Package Name
            Center(
              child: Text(
                packageName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFFF26A21),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Services List
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: services
                    .map(
                      (service) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0D4A58),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                service,
                                style: const TextStyle(
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xFF0D4A58),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 12),

            // Price Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFE0E0E0)
                    : const Color(0xFFD8F6F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  price,
                  style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF0D4A58),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
