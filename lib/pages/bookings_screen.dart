import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  String selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 2; // Profile tab is selected since we're in bookings

  final List<String> filterTabs = ['All', 'Upcoming', 'Completed', 'Cancelled'];

  final List<Map<String, dynamic>> bookings = [
    {
      'serviceName': 'Full Service',
      'carModel': 'Mercedes-Benz C-Class',
      'dateTime': 'Oct 25, 2023 - 10:00 AM',
      'status': 'Completed',
      'carImage': 'assets/images/mercedes_c_class.png',
    },
    {
      'serviceName': 'Interior Detailing',
      'carModel': 'BMW 3 Series',
      'dateTime': 'Nov 15, 2023 - 02:00 PM',
      'status': 'Upcoming',
      'carImage': 'assets/images/bmw_3_series.png',
    },
    {
      'serviceName': 'Exterior Wash',
      'carModel': 'Audi A4',
      'dateTime': 'Oct 20, 2023 - 09:00 AM',
      'status': 'Completed',
      'carImage': 'assets/images/audi_a4.png',
    },
    {
      'serviceName': 'Exterior Wash',
      'carModel': 'Tesla Model S',
      'dateTime': 'Oct 18, 2023 - 03:30 PM',
      'status': 'Cancelled',
      'carImage': 'assets/images/tesla_model_s.png',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredBookings {
    if (selectedFilter == 'All') {
      return bookings;
    }
    return bookings
        .where((booking) => booking['status'] == selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Bookings',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3E50),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.all(16),
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
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search bookings...',
                hintStyle: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 16,
                  color: Color(0xFF7F8C8D),
                ),
                prefixIcon: Icon(Icons.search, color: Color(0xFF7F8C8D)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),

          // Filter Tabs
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filterTabs.length,
              itemBuilder: (context, index) {
                final filter = filterTabs[index];
                final isSelected = selectedFilter == filter;

                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF20B2AA)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: isSelected
                            ? null
                            : Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Bookings List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredBookings.length,
              itemBuilder: (context, index) {
                final booking = filteredBookings[index];
                return _buildBookingCard(booking);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        break;
      case 1:
        // Navigate to request screen (index 1 in main navigation)
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        // Then navigate to request tab
        break;
      case 2:
        // Navigate to profile screen (index 2 in main navigation)
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        // Then navigate to profile tab
        break;
    }
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/booking-details', arguments: booking),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
            // Car Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.directions_car,
                color: Color(0xFF666666),
                size: 40,
              ),
            ),

            const SizedBox(width: 16),

            // Booking Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking['serviceName'],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking['carModel'],
                    style: const TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF7F8C8D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking['dateTime'],
                    style: const TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7F8C8D),
                    ),
                  ),
                ],
              ),
            ),

            // Status Badge
            _buildStatusBadge(booking['status']),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'Completed':
        backgroundColor = const Color(0xFFE6F7ED);
        textColor = const Color(0xFF52C41A);
        break;
      case 'Upcoming':
        backgroundColor = const Color(0xFFFFF3E0);
        textColor = const Color(0xFFFA8C16);
        break;
      case 'Cancelled':
        backgroundColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFFFF4D4F);
        break;
      default:
        backgroundColor = const Color(0xFFF0F0F0);
        textColor = const Color(0xFF666666);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontFamily: 'Mulish',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
