import 'package:flutter/material.dart';
import '../widgets/vehicle_selection_list.dart';
import '../widgets/location_selection_list.dart';
import '../services/booking_service.dart';
import '../services/vehicle_service.dart';
import '../services/models/service_vehicle_models.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  int currentStep = 0;
  int selectedPackageIndex = 0;
  int selectedCarIndex = 0;
  int selectedAddressIndex = 0;
  int selectedDateTimeIndex = 0;
  int selectedPaymentMethod = 0; // 0 = Credit Card, 1 = PayPal
  String promoCode = '';
  bool isPromoApplied = false;


  // API Services
  List<CarWashService> _apiServices = [];
  bool _isLoadingServices = false;

  // Vehicles data
  List<Vehicle> _apiVehicles = [];
  bool _isLoadingVehicles = false;

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

  final List<Map<String, dynamic>> addresses = [
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

  final List<Map<String, dynamic>> timeSlots = [
    {'time': '9:00 AM', 'available': true},
    {'time': '10:00 AM', 'available': true},
    {'time': '11:00 AM', 'available': true},
    {'time': '12:00 PM', 'available': true},
    {'time': '1:00 PM', 'available': true},
    {'time': '2:00 PM', 'available': true},
    {'time': '3:00 PM', 'available': true},
    {'time': '4:00 PM', 'available': true},
    {'time': '5:00 PM', 'available': true},
  ];

  DateTime selectedDate = DateTime.now().add(
    const Duration(days: 4),
  ); // Default to 5th of current month
  int selectedTimeIndex = 1; // Default to 10:00 AM

  final List<String> stepTitles = [
    'Choose Your Service',
    'Select Your Car',
    'Choose Location',
    'Pick Date & Time',
  ];

  @override
  void initState() {
    super.initState();
    _loadServices();
    _loadVehicles();
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
          _apiServices = response.data!;
        });
      }
    } catch (e) {
      print('Error loading services: $e');
    } finally {
      setState(() {
        _isLoadingServices = false;
      });
    }
  }

  Future<void> _loadVehicles() async {
    setState(() {
      _isLoadingVehicles = true;
    });

    try {
      final vehicleService = VehicleService();
      final response = await vehicleService.getVehicles();
      
      if (response.isSuccess && response.data != null) {
        setState(() {
          _apiVehicles = response.data!;
        });
      } else {
        print('Failed to load vehicles: ${response.error}');
      }
    } catch (e) {
      print('Failed to load vehicles: $e');
    } finally {
      setState(() {
        _isLoadingVehicles = false;
      });
    }
  }

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
          onPressed: () {
            // If we're in step 0 (service selection), go to home
            // Otherwise, go to previous step
            if (currentStep == 0) {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            } else {
              setState(() {
                currentStep--;
              });
            }
          },
        ),
        title: Text(
          currentStep < 4
              ? stepTitles[currentStep]
              : currentStep == 4
              ? 'Order Summary'
              : 'Payment Details',
          style: const TextStyle(
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
      body: Column(
        children: [
          // Progress Bar (only for main steps 0-3)
          if (currentStep < 4) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (currentStep + 1) / 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF0D4A58),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${currentStep + 1}/4',
                        style: const TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],

          // Step Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _buildStepContent(),
            ),
          ),

          // Navigation Buttons (hidden on order summary and payment screens)
          if (currentStep < 4) ...[
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  if (currentStep > 0) ...[
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              currentStep--;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF0D4A58)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Previous',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF0D4A58),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _canProceed() ? _nextStep : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D4A58),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          currentStep == 3 ? 'Continue' : 'Continue',
                          style: const TextStyle(
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildServiceSelection();
      case 1:
        return _buildCarSelection();
      case 2:
        return _buildLocationSelection();
      case 3:
        return _buildDateTimeSelection();
      case 4:
        return _buildOrderSummary();
      case 5:
        return _buildPaymentDetails();
      default:
        return _buildServiceSelection();
    }
  }

  Widget _buildServiceSelection() {
    if (_isLoadingServices) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF0D4A58),
        ),
      );
    }

    if (_apiServices.isEmpty) {
      return const Center(
        child: Text(
          'No services available',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontSize: 16,
            color: Color(0xFF666666),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        ..._apiServices.asMap().entries.map((entry) {
          final index = entry.key;
          final service = entry.value;
          final isSelected = selectedPackageIndex == index;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPackageIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFE0F7FA)
                      : const Color(0xFFF8F9FA),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                service.name,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: isSelected
                                      ? const Color(0xFF0D4A58)
                                      : const Color(0xFF333333),
                                ),
                              ),
                              Text(
                                '${service.price.toStringAsFixed(0)} LE',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: isSelected
                                      ? const Color(0xFF0D4A58)
                                      : const Color(0xFF333333),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${service.durationInMinutes} min',
                            style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            service.description,
                            style: const TextStyle(
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCarSelection() {
    if (_isLoadingVehicles) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF0D4A58),
        ),
      );
    }

    if (_apiVehicles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_car_outlined,
              size: 64,
              color: Color(0xFF666666),
            ),
            const SizedBox(height: 16),
            const Text(
              'No vehicles found',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your first vehicle to continue',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/add-car'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D4A58),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Add Vehicle',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return VehicleSelectionList(
      vehicles: _apiVehicles,
      selectedIndex: selectedCarIndex,
      onVehicleSelected: (index) {
        setState(() {
          selectedCarIndex = index;
        });
      },
      onAddVehicle: () => Navigator.pushNamed(context, '/add-car'),
      showAddButton: true,
      title: 'Select Your Car',
      isSelectionMode: true,
    );
  }

  Widget _buildLocationSelection() {
    return LocationSelectionList(
      locations: addresses,
      selectedIndex: selectedAddressIndex,
      onLocationSelected: (index) {
        setState(() {
          selectedAddressIndex = index;
        });
      },
      onAddLocation: () => Navigator.pushNamed(context, '/location-picker'),
      showAddButton: true,
      title: 'Choose Your Location',
      isSelectionMode: true,
    );
  }

  Widget _buildDateTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Calendar Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              // Calendar Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = DateTime(
                          selectedDate.year,
                          selectedDate.month - 1,
                        );
                      });
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Color(0xFF0D4A58),
                    ),
                  ),
                  Text(
                    '${_getMonthName(selectedDate.month)} ${selectedDate.year}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(0xFF0D4A58),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = DateTime(
                          selectedDate.year,
                          selectedDate.month + 1,
                        );
                      });
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF0D4A58),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Days of week
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'S',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                  Text(
                    'M',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                  Text(
                    'T',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                  Text(
                    'W',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                  Text(
                    'T',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                  Text(
                    'F',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                  Text(
                    'S',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Calendar Grid
              _buildCalendarGrid(),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Time Selection Section
        const Text(
          'Select Time',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF0D4A58),
          ),
        ),
        const SizedBox(height: 16),

        // Time Slots Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: timeSlots.length,
          itemBuilder: (context, index) {
            final slot = timeSlots[index];
            final isSelected = selectedTimeIndex == index;
            final isAvailable = slot['available'] as bool;

            return GestureDetector(
              onTap: isAvailable
                  ? () {
                      setState(() {
                        selectedTimeIndex = index;
                      });
                    }
                  : null,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: !isAvailable
                      ? const Color(0xFFF5F5F5)
                      : isSelected
                      ? const Color(0xFF00BCD4)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: !isAvailable
                        ? const Color(0xFFE0E0E0)
                        : isSelected
                        ? const Color(0xFF00BCD4)
                        : const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    slot['time'],
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: !isAvailable
                          ? const Color(0xFF999999)
                          : isSelected
                          ? Colors.white
                          : const Color(0xFF333333),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    );
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    final List<Widget> calendarDays = [];

    // Add empty cells for days before the first day of the month
    for (int i = 0; i < firstWeekday; i++) {
      calendarDays.add(const SizedBox());
    }

    // Add days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final isSelected = selectedDate.day == day;
      calendarDays.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = DateTime(
                selectedDate.year,
                selectedDate.month,
                day,
              );
            });
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? const Color(0xFF00BCD4) : Colors.transparent,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isSelected ? Colors.white : const Color(0xFF333333),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Wrap(children: calendarDays);
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  Widget _buildOrderSummary() {
    final selectedService = _apiServices[selectedPackageIndex];
    final selectedCar = cars[selectedCarIndex];
    final selectedAddress = addresses[selectedAddressIndex];
    final selectedTime = timeSlots[selectedTimeIndex];

    // Calculate pricing
    final packagePrice = selectedService.price;
    final serviceFee = 5.0;
    final total = packagePrice + serviceFee;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Service Package Section
        const Text(
          'Service Package',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF0D4A58),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D4A58),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.directions_car,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedService.name,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF0D4A58),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      selectedService.description,
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
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Vehicle Details Section
        const Text(
          'Vehicle Details',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF0D4A58),
          ),
        ),
        const SizedBox(height: 12),

        // Car Info
        _buildDetailRow(
          Icons.directions_car,
          selectedCar['brand'] + ' ' + selectedCar['model'],
          selectedCar['details'],
        ),

        const SizedBox(height: 12),

        // Date & Time
        _buildDetailRow(
          Icons.calendar_today,
          _formatDateTime(selectedDate, selectedTime['time']),
          null,
        ),

        const SizedBox(height: 12),

        // Location
        _buildDetailRow(
          Icons.location_on,
          selectedAddress['title'],
          selectedAddress['address'],
        ),

        const SizedBox(height: 24),

        // Price Breakdown Section
        const Text(
          'Price Breakdown',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF0D4A58),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              _buildPriceRow(selectedService.name, packagePrice),
              const SizedBox(height: 8),
              _buildPriceRow('Service Fee', serviceFee),
              const Divider(color: Color(0xFFE0E0E0), height: 24),
              _buildPriceRow('Total', total, isTotal: true),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Action Buttons
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _proceedToPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D4A58),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Proceed to Payment',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: _editOrder,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF0D4A58)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Edit Order',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF0D4A58),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String? subtitle) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0D4A58), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF0D4A58),
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            fontSize: isTotal ? 16 : 14,
            color: const Color(0xFF0D4A58),
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            fontSize: isTotal ? 16 : 14,
            color: const Color(0xFF0D4A58),
          ),
        ),
      ],
    );
  }

  double _extractPrice(String priceString) {
    // Extract numeric value from price string like "800 LE"
    final regex = RegExp(r'(\d+)');
    final match = regex.firstMatch(priceString);
    return match != null ? double.parse(match.group(1)!) : 0.0;
  }

  String _formatDateTime(DateTime date, String time) {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];
    final day = date.day;
    final year = date.year;

    return '$weekday, $month $day, $year · $time';
  }

  Widget _buildPaymentDetails() {
    final selectedService = _apiServices[selectedPackageIndex];
    final packagePrice = selectedService.price;
    final serviceFee = 5.0;
    final discount = isPromoApplied ? 10.0 : 0.0; // 10% discount for demo
    final total = packagePrice + serviceFee - discount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Payment Method Section
        const Text(
          'Payment Method',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF0D4A58),
          ),
        ),
        const SizedBox(height: 16),

        // Credit Card Option
        GestureDetector(
          onTap: () {
            setState(() {
              selectedPaymentMethod = 0;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedPaymentMethod == 0
                    ? const Color(0xFF00BCD4)
                    : const Color(0xFFE0E0E0),
                width: selectedPaymentMethod == 0 ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Credit Card',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF0D4A58),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedPaymentMethod == 0
                        ? const Color(0xFF00BCD4)
                        : Colors.transparent,
                    border: Border.all(
                      color: selectedPaymentMethod == 0
                          ? const Color(0xFF00BCD4)
                          : const Color(0xFFE0E0E0),
                      width: 2,
                    ),
                  ),
                  child: selectedPaymentMethod == 0
                      ? const Icon(Icons.check, color: Colors.white, size: 12)
                      : null,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // PayPal Option
        GestureDetector(
          onTap: () {
            setState(() {
              selectedPaymentMethod = 1;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedPaymentMethod == 1
                    ? const Color(0xFF00BCD4)
                    : const Color(0xFFE0E0E0),
                width: selectedPaymentMethod == 1 ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Cash On Delivery',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF0D4A58),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedPaymentMethod == 1
                        ? const Color(0xFF00BCD4)
                        : Colors.transparent,
                    border: Border.all(
                      color: selectedPaymentMethod == 1
                          ? const Color(0xFF00BCD4)
                          : const Color(0xFFE0E0E0),
                      width: 2,
                    ),
                  ),
                  child: selectedPaymentMethod == 1
                      ? const Icon(Icons.check, color: Colors.white, size: 12)
                      : null,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Promo Code Section
        const Text(
          'Promo Code',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF0D4A58),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    promoCode = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter promo code',
                  hintStyle: const TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF00BCD4),
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _applyPromoCode,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF00BCD4)),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF00BCD4),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Price Breakdown Section
        const Text(
          'Price Breakdown',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF0D4A58),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              _buildPaymentPriceRow(selectedService.name, packagePrice),
              const SizedBox(height: 8),
              _buildPaymentPriceRow('Service Fee', serviceFee),
              if (isPromoApplied) ...[
                const SizedBox(height: 8),
                _buildPaymentPriceRow('Discount', -discount, isDiscount: true),
              ],
              const Divider(color: Color(0xFFE0E0E0), height: 24),
              _buildPaymentPriceRow('Total', total, isTotal: true),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Book Now Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _bookNow,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BCD4),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentPriceRow(
    String label,
    double amount, {
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            fontSize: isTotal ? 16 : 14,
            color: const Color(0xFF0D4A58),
          ),
        ),
        Text(
          '${amount >= 0 ? '\$' : '-\$'}${amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            fontSize: isTotal ? 16 : 14,
            color: isDiscount
                ? const Color(0xFF00BCD4)
                : const Color(0xFF0D4A58),
          ),
        ),
      ],
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedPackageIndex >= 0;
      case 1:
        return selectedCarIndex >= 0;
      case 2:
        return selectedAddressIndex >= 0;
      case 3:
        return selectedTimeIndex >= 0;
      default:
        return false;
    }
  }

  void _nextStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    } else {
      // Show order summary
      setState(() {
        currentStep = 4; // Order summary step
      });
    }
  }

  void _editOrder() {
    setState(() {
      currentStep = 3; // Go back to date/time selection
    });
  }

  void _proceedToPayment() {
    setState(() {
      currentStep = 5; // Go to payment details
    });
  }

  void _bookNow() {
    // Navigate to order complete page with booking details
    final selectedPackage = packages[selectedPackageIndex];
    final selectedAddress = addresses[selectedAddressIndex];
    final selectedTime = timeSlots[selectedTimeIndex];

    Navigator.pushNamed(
      context,
      '/order-complete',
      arguments: {
        'serviceName': selectedPackage['name'],
        'date': selectedTime['date'],
        'time': selectedTime['time'],
        'location': selectedAddress['address'],
        'price': selectedPackage['price'],
      },
    );
  }

  void _applyPromoCode() {
    if (promoCode.isNotEmpty) {
      setState(() {
        isPromoApplied = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Promo code applied successfully!'),
          backgroundColor: Color(0xFF0D4A58),
        ),
      );
    }
  }
}
