import 'package:flutter/material.dart';
import 'dart:async';
import 'package:glint/services/booking_service.dart';
import 'package:glint/services/models/service_vehicle_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late Timer _timer;
  bool _isUserInteracting = false;
  final int _unreadNotificationCount =
      1; // This would typically come from a service
  
  // Real data from API
  List<CarWashService> _services = [];
  bool _isLoadingServices = false;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    _loadServices();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageController.hasClients && !_isUserInteracting) {
        _currentIndex = (_currentIndex + 1) % _getBannerData().length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onUserInteraction() {
    setState(() {
      _isUserInteracting = true;
    });

    // Resume auto-slide after 5 seconds of no interaction
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isUserInteracting = false;
        });
      }
    });
  }

  Future<void> _loadServices() async {
    setState(() {
      _isLoadingServices = true;
    });

    try {
      final bookingService = BookingService();
      final response = await bookingService.getServices();

      if (response.isSuccess && response.data != null) {
        setState(() {
          _services = response.data!;
        });
      } else {
        // Handle error - could show a snackbar or use fallback data
        print('Failed to load services: ${response.error}');
      }
    } catch (e) {
      // Handle network error
      print('Network error loading services: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingServices = false;
        });
      }
    }
  }

  List<Map<String, dynamic>> _getBannerData() {
    return [
      {
        'title': 'From wash to shine,\nwe\'ve got you covered',
        'image': 'assets/images/home_car.png',
      },
      {
        'title': 'Professional car care\nat your doorstep',
        'image': 'assets/images/home_car.png',
      },
      {
        'title': 'Book now and save\ntime and effort',
        'image': 'assets/images/home_car.png',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Greeting Section
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/home_hand.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xFF666666),
                            ),
                          ),
                          Text(
                            'Ahmed',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Color(0xFF0D4A58),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Notifications and Menu
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/notifications');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                'assets/icons/notifications.png',
                                width: 24,
                                height: 24,
                                color: const Color(0xFFE04703),
                              ),
                              if (_unreadNotificationCount > 0)
                                Positioned(
                                  right: -4,
                                  top: -4,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF064A58),
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 18,
                                      minHeight: 18,
                                    ),
                                    child: Text(
                                      _unreadNotificationCount > 99
                                          ? '99+'
                                          : _unreadNotificationCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        child: Image.asset(
                          'assets/icons/burger.png',
                          width: 24,
                          height: 24,
                          color: const Color(0xFFE04703),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Promotional Banner Carousel
              SizedBox(
                height: 120,
                child: GestureDetector(
                  onPanStart: (_) => _onUserInteraction(),
                  onPanUpdate: (_) => _onUserInteraction(),
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                      _onUserInteraction();
                    },
                    itemCount: _getBannerData().length,
                    itemBuilder: (context, index) {
                      final banner = _getBannerData()[index];
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D4A58),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      banner['title'],
                                      style: const TextStyle(
                                        fontFamily: 'Mulish',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Colors.white,
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  banner['image'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Page Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _getBannerData().length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? const Color(0xFF0D4A58)
                          : const Color(0xFFE0E0E0),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Location Input Field
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Add Your Location',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF666666),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Your Requests Section
              const Text(
                'Your Requests',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Color(0xFF0D4A58),
                ),
              ),

              const SizedBox(height: 12),

              // Active Request Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F8FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.directions_car,
                              color: Color(0xFF0D4A58),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'VIP carwash',
                                  style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFF0D4A58),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Sat, 13 Sep 2025 / 12:30 PM',
                                  style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE04703),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'On going',
                              style: TextStyle(
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Progress Bar
                      Row(
                        children: [
                          _buildProgressStep('Received', true, true),
                          Expanded(child: _buildProgressConnector(true)),
                          _buildProgressStep('Washing', false, true),
                          Expanded(child: _buildProgressConnector(false)),
                          _buildProgressStep('Cleaning', false, true),
                          Expanded(child: _buildProgressConnector(false)),
                          _buildProgressStep('Delivery', false, false),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStep(String label, bool isActive, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0D4A58) : Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: isActive ? const Color(0xFF0D4A58) : Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressConnector(bool isActive) {
    return Container(
      height: 2,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0D4A58) : Colors.grey[300],
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
