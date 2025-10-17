import 'package:flutter/material.dart';
import '../widgets/location_selection_list.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  int? selectedIndex;

  // Sample location data - in a real app, this would come from a service or database
  final List<Map<String, dynamic>> locations = [
    {'title': 'Home', 'address': '123 Main St, Cairo', 'isDefault': true},
    {
      'title': 'Office',
      'address': '456 Business Ave, Giza',
      'isDefault': false,
    },
    {
      'title': 'Other',
      'address': '789 Other St, Alexandria',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Locations',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3E50),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/location-picker'),
            icon: const Icon(
              Icons.add_location,
              color: Color(0xFF20B2AA),
              size: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: LocationSelectionList(
          locations: locations,
          selectedIndex: selectedIndex,
          onLocationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          onAddLocation: () => Navigator.pushNamed(context, '/location-picker'),
          showAddButton: true,
          title: 'My Locations',
          isSelectionMode: false, // Management mode, not selection mode
        ),
      ),
    );
  }
}
