import 'package:flutter/material.dart';

class CarTileSmall extends StatelessWidget {
  final String brand;
  final String model;
  final String details;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onMore;
  const CarTileSmall({
    super.key,
    required this.brand,
    required this.model,
    required this.details,
    this.isSelected = false,
    this.onTap,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 96,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD8F6F6) : const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0D4A58)
                : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onTap: onMore,
                child: const Icon(
                  Icons.more_vert,
                  size: 14,
                  color: Color(0xFFE04703),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  brand,
                  style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  model,
                  style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  details,
                  style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
