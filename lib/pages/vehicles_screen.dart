import 'package:flutter/material.dart';
import '../widgets/vehicle_selection_list.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({super.key});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  int? selectedIndex;

  // Sample vehicle data - in a real app, this would come from a service or database
  final List<Map<String, dynamic>> vehicles = [
    {'brand': 'Renault', 'model': 'Sandero', 'details': 'Grey . 2451 س ن'},
    {'brand': 'Toyota', 'model': 'Corolla', 'details': 'White . 1234 أ ب'},
    {'brand': 'Honda', 'model': 'Civic', 'details': 'Black . 5678 ج د'},
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
          'My Vehicles',
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
            onPressed: () => Navigator.pushNamed(context, '/add-car'),
            icon: const Icon(Icons.add, color: Color(0xFF20B2AA), size: 24),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: VehicleSelectionList(
          vehicles: vehicles,
          selectedIndex: selectedIndex,
          onVehicleSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          onAddVehicle: () => Navigator.pushNamed(context, '/add-car'),
          showAddButton: true,
          title: 'My Vehicles',
          isSelectionMode: false, // Management mode, not selection mode
        ),
      ),
    );
  }
}
