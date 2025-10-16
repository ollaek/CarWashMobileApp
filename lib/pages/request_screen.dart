import 'package:flutter/material.dart';
import 'package:glint/widgets/car_cleaning_package_card.dart';
import 'package:glint/widgets/profile/car_tile_small.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  int selectedPackageIndex = 0;
  int selectedCarIndex = 0;

  final List<Map<String, dynamic>> packages = [
    {
      'name': 'Basic Wash',
      'duration': '20-25 min',
      'services': ['Exterior hand wash', 'Quick dry', 'Tire shine'],
      'price': '200 LE',
    },
    {
      'name': 'Standard Wash',
      'duration': '30-45 min',
      'services': [
        'Exterior wash + wax',
        'Interior vacuum',
        'Dashboard wipe',
        'Windows (inside & out)',
      ],
      'price': '500 LE',
    },
    {
      'name': 'Premium Wash',
      'duration': '45-60 min',
      'services': [
        'Full exterior detail',
        'Interior deep clean',
        'Leather conditioning',
        'Engine bay cleaning',
        'Tire shine',
      ],
      'price': '800 LE',
    },
    {
      'name': 'Deluxe Wash',
      'duration': '60-90 min',
      'services': [
        'Complete exterior detail',
        'Full interior deep clean',
        'Leather treatment',
        'Engine bay detail',
        'Tire shine & dressing',
        'Paint protection',
      ],
      'price': '1200 LE',
    },
  ];

  final List<Map<String, dynamic>> cars = [
    {'brand': 'Renault', 'model': 'Sandero', 'details': 'Grey . 2451 س ن'},
    {'brand': 'Toyota', 'model': 'Corolla', 'details': 'White . 1234 أ ب'},
    {'brand': 'Honda', 'model': 'Civic', 'details': 'Black . 5678 ج د'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0D4A58),
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Carwash Request',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Color(0xFF0D4A58),
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF0D4A58),
                  size: 24,
                ),
                onPressed: () {
                  // TODO: Navigate to notifications
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: Color(0xFF0D4A58),
              size: 24,
            ),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Package Title
            const Text(
              'Select Package',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF0D4A58),
              ),
            ),

            const SizedBox(height: 20),

            // Horizontal scrollable package cards
            SizedBox(
              height: 320,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: packages.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final package = packages[index];
                  return SizedBox(
                    width: 280,
                    child: CarCleaningPackageCard(
                      packageName: package['name'],
                      duration: package['duration'],
                      services: List<String>.from(package['services']),
                      price: package['price'],
                      isSelected: selectedPackageIndex == index,
                      onTap: () {
                        setState(() {
                          selectedPackageIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Select Car Title
            const Text(
              'Select Car',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF0D4A58),
              ),
            ),

            const SizedBox(height: 12),

            // Horizontal scrollable car tiles
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: cars.length + 1, // +1 for "Add New Car" tile
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  if (index == cars.length) {
                    // Add New Car tile
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/add-car'),
                      child: Container(
                        width: 150,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: Color(0xFF0D4A58),
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Add New Car',
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF0D4A58),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  final car = cars[index];
                  return SizedBox(
                    width: 150,
                    child: CarTileSmall(
                      brand: car['brand'],
                      model: car['model'],
                      details: car['details'],
                      isSelected: selectedCarIndex == index,
                      onTap: () {
                        setState(() {
                          selectedCarIndex = index;
                        });
                      },
                      onMore: () {
                        // TODO: Show car options
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to next step
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: ${packages[selectedPackageIndex]['name']}',
                      ),
                      backgroundColor: const Color(0xFF0D4A58),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D4A58),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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
