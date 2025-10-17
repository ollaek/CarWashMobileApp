import 'package:flutter/material.dart';

class LocationSelectionList extends StatelessWidget {
  final List<Map<String, dynamic>> locations;
  final int? selectedIndex;
  final Function(int) onLocationSelected;
  final VoidCallback? onAddLocation;
  final bool showAddButton;
  final String title;
  final bool isSelectionMode;

  const LocationSelectionList({
    super.key,
    required this.locations,
    this.selectedIndex,
    required this.onLocationSelected,
    this.onAddLocation,
    this.showAddButton = true,
    this.title = 'Choose Your Location',
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
        ...locations.asMap().entries.map((entry) {
          final index = entry.key;
          final location = entry.value;
          final isSelected = selectedIndex == index;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () => onLocationSelected(index),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFE8F4F8) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF0D4A58)
                        : const Color(0xFFE0E0E0),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Location Icon
                    Icon(
                      Icons.location_on,
                      color: isSelected
                          ? const Color(0xFF0D4A58)
                          : const Color(0xFF666666),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    // Location Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location['title'],
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: isSelected
                                  ? const Color(0xFF0D4A58)
                                  : const Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            location['address'],
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
                    // Default Badge (if applicable)
                    if (location['isDefault'] == true)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D4A58),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Default',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    // Selection Indicator (only in selection mode)
                    if (isSelectionMode && location['isDefault'] != true)
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? const Color(0xFF0D4A58)
                              : Colors.transparent,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF0D4A58)
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
                        onPressed: () =>
                            _showLocationOptions(context, location),
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
        }).toList(),

        // Add New Location Button
        if (showAddButton) ...[
          const SizedBox(height: 20),
          GestureDetector(
            onTap:
                onAddLocation ??
                () => Navigator.pushNamed(context, '/location-picker'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF0D4A58),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_location, color: Color(0xFF0D4A58), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Add New Location',
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

  void _showLocationOptions(
    BuildContext context,
    Map<String, dynamic> location,
  ) {
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
                // TODO: Navigate to edit location screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Edit ${location['title']}'),
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
                    content: Text('Delete ${location['title']}'),
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
