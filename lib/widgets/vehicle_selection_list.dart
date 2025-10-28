import 'package:flutter/material.dart';

class VehicleSelectionList extends StatelessWidget {
  final List<Map<String, dynamic>> vehicles;
  final int? selectedIndex;
  final Function(int) onVehicleSelected;
  final VoidCallback? onAddVehicle;
  final bool showAddButton;
  final String title;
  final bool isSelectionMode;

  const VehicleSelectionList({
    super.key,
    required this.vehicles,
    this.selectedIndex,
    required this.onVehicleSelected,
    this.onAddVehicle,
    this.showAddButton = true,
    this.title = 'Select Your Car',
    this.isSelectionMode = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF0D4A58),
          ),
        ),
        const SizedBox(height: 20),
        ...vehicles.asMap().entries.map((entry) {
          final index = entry.key;
          final vehicle = entry.value;
          final isSelected = selectedIndex == index;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () => onVehicleSelected(index),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFE0F7FA) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF00BCD4)
                        : const Color(0xFFE0E0E0),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Car Image Placeholder
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.directions_car,
                        color: Color(0xFF666666),
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Car Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vehicle['brand'],
                            style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            vehicle['model'],
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: isSelected
                                  ? const Color(0xFF0D4A58)
                                  : const Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            vehicle['details'],
                            style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Selection Indicator (only in selection mode)
                    if (isSelectionMode)
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? const Color(0xFF00BCD4)
                              : Colors.transparent,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF00BCD4)
                                : const Color(0xFFE0E0E0),
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                            : null,
                      ),
                    // Action buttons for management mode
                    if (!isSelectionMode) ...[
                      IconButton(
                        onPressed: () => _showVehicleOptions(context, vehicle),
                        icon: const Icon(
                          Icons.more_vert,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),

        // Add New Vehicle Button
        if (showAddButton) ...[
          const SizedBox(height: 20),
          GestureDetector(
            onTap:
                onAddVehicle ?? () => Navigator.pushNamed(context, '/add-car'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F7FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00BCD4), width: 2),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Color(0xFF0D4A58), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Add New Vehicle',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF0D4A58),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showVehicleOptions(BuildContext context, Map<String, dynamic> vehicle) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0D4A58),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white, size: 20),
              title: const Text(
                'Edit',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to edit vehicle screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Edit ${vehicle['brand']} ${vehicle['model']}',
                    ),
                    backgroundColor: const Color(0xFF0D4A58),
                  ),
                );
              },
            ),
            const Divider(color: Colors.white24, height: 1),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.white, size: 20),
              title: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Show delete confirmation dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Delete ${vehicle['brand']} ${vehicle['model']}',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
