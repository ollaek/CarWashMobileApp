# CarWash Mobile App - API Integration Guide

## Overview
This guide explains how the Flutter mobile app integrates with the .NET CarWash API backend running on `https://localhost:5001/`.

## 🏗️ Architecture

### API Service Layer
- **ApiService**: Main service class that handles all API communication
- **AuthService**: Handles authentication operations (login, register, etc.)
- **VehicleService**: Manages vehicle operations
- **BookingService**: Handles booking operations
- **ServiceLocator**: Dependency injection container

### Model Classes
All API models are defined in `lib/services/models/` with JSON serialization support:
- `auth_models.dart` - Authentication related models
- `service_vehicle_models.dart` - Services, vehicles, car brands/models/colors
- `booking_models.dart` - Booking operations
- `address_models.dart` - Address management
- `payment_card_models.dart` - Payment card management
- `promocode_models.dart` - Promocode validation
- `common_models.dart` - Common models like UserProfile, Notifications

## 🔧 Configuration

### API Base URL
The API base URL is configured in `lib/services/api/api_config.dart`:
```dart
class ApiConfig {
  static const String baseUrl = 'https://localhost:5001';
}
```

### Authentication
- JWT tokens are automatically handled by the `AuthInterceptor`
- Tokens are stored securely using `SharedPreferences`
- Automatic token refresh is handled by the interceptor

## 📱 Usage Examples

### 1. Authentication
```dart
// Login
final authService = AuthService();
final response = await authService.login(email, password);

if (response.isSuccess) {
  // User is logged in, navigate to home
  Navigator.pushReplacementNamed(context, '/home');
} else {
  // Show error message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(response.error ?? 'Login failed')),
  );
}
```

### 2. Fetching Services
```dart
// Get car wash services
final bookingService = BookingService();
final response = await bookingService.getServices();

if (response.isSuccess && response.data != null) {
  final services = response.data!;
  // Update UI with services
}
```

### 3. Managing Vehicles
```dart
// Get user's vehicles
final vehicleService = VehicleService();
final response = await vehicleService.getVehicles();

// Create new vehicle
final createResponse = await vehicleService.createVehicle(
  carBrandId: 1,
  carModelId: 2,
  carColorId: 3,
  licensePlateNumber: 'ABC123',
  yearOfManufacture: 2020,
  isDefault: true,
);
```

### 4. Creating Bookings
```dart
// Create a new booking
final bookingService = BookingService();
final response = await bookingService.createBooking(
  serviceId: 1,
  vehicleId: 1,
  addressId: 1,
  scheduledDateTime: DateTime.now().add(Duration(days: 1)),
  paymentMethod: PaymentMethod.method1,
  notes: 'Please wash carefully',
);
```

## 🔄 Error Handling

All API calls return an `ApiResponse<T>` object:
```dart
class ApiResponse<T> {
  final bool isSuccess;
  final T? data;
  final String? error;
}
```

### Example Error Handling
```dart
try {
  final response = await authService.login(email, password);
  
  if (response.isSuccess) {
    // Success - use response.data
  } else {
    // API error - show response.error
    showErrorSnackBar(response.error ?? 'Unknown error');
  }
} catch (e) {
  // Network error
  showErrorSnackBar('Network error: ${e.toString()}');
}
```

## 🚀 Getting Started

### 1. Start the .NET API
```bash
cd CarWashApi/CarWash.Presentation
dotnet run
```
The API will be available at `https://localhost:5001/`

### 2. Run the Flutter App
```bash
cd CarWashMobileApp
flutter run
```

### 3. Test the Integration
1. Open the app
2. Try to login with valid credentials
3. Check if services are loaded from the API
4. Test vehicle management
5. Test booking creation

## 📋 Available API Endpoints

### Authentication
- `POST /api/Auth/register` - User registration
- `POST /api/Auth/login` - User login
- `POST /api/Auth/verify-email` - Email verification
- `POST /api/Auth/forgot-password` - Password reset request
- `POST /api/Auth/reset-password` - Password reset

### Services
- `GET /api/Services` - Get all car wash services
- `GET /api/Lookups/car-brands` - Get car brands
- `GET /api/Lookups/car-models/{brandId}` - Get car models by brand
- `GET /api/Lookups/car-colors` - Get car colors

### Vehicles
- `GET /api/Vehicles` - Get user's vehicles
- `POST /api/Vehicles` - Create new vehicle
- `PUT /api/Vehicles/{id}` - Update vehicle
- `DELETE /api/Vehicles/{id}` - Delete vehicle

### Addresses
- `GET /api/Addresses` - Get user's addresses
- `POST /api/Addresses` - Create new address
- `PUT /api/Addresses/{id}` - Update address
- `DELETE /api/Addresses/{id}` - Delete address

### Bookings
- `GET /api/Bookings` - Get user's bookings
- `POST /api/Bookings` - Create new booking
- `GET /api/Bookings/active` - Get active bookings
- `GET /api/Bookings/history` - Get booking history
- `PUT /api/Bookings/{id}/cancel` - Cancel booking

### Payment Cards
- `GET /api/PaymentCards` - Get user's payment cards
- `POST /api/PaymentCards` - Add new payment card
- `DELETE /api/PaymentCards/{id}` - Delete payment card

## 🔧 Development Notes

### Code Generation
After adding new models or modifying existing ones, run:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Testing
- Use the Swagger UI at `https://localhost:5001/swagger` to test API endpoints
- Check the Flutter console for API response logs
- Use the network inspector to debug API calls

### Troubleshooting

#### Common Issues:
1. **CORS errors**: Make sure the API has CORS enabled for localhost
2. **SSL certificate errors**: The API uses HTTPS, ensure certificates are valid
3. **Network timeouts**: Check if the API is running and accessible
4. **Authentication errors**: Verify JWT token handling

#### Debug Steps:
1. Check if the API is running: `https://localhost:5001/api/Health`
2. Verify API responses in Swagger UI
3. Check Flutter console for error messages
4. Use network debugging tools to inspect requests

## 📱 UI Integration

The app has been updated to use real API data in:
- **SigninScreen**: Real authentication with loading states
- **HomeScreen**: Fetches real services from API
- **Other screens**: Ready for API integration following the same patterns

## 🎯 Next Steps

1. **Complete UI Integration**: Update all screens to use real API data
2. **Error Handling**: Implement comprehensive error handling
3. **Offline Support**: Add offline capabilities with local storage
4. **Push Notifications**: Integrate with Firebase for notifications
5. **Payment Integration**: Implement real payment processing
6. **Testing**: Add unit and integration tests

## 📞 Support

For issues or questions:
1. Check the API documentation at `https://localhost:5001/swagger`
2. Review the Flutter console for error messages
3. Test API endpoints directly using Swagger UI
4. Verify network connectivity and API availability
