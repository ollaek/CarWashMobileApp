import 'dart:io';
import 'package:dio/dio.dart';
import 'package:glint/services/api/api_client.dart';
import 'package:glint/services/api/dio_provider.dart';
import 'package:glint/services/api/token_storage.dart';
import 'package:glint/services/auth_service.dart';
import 'package:glint/services/models/auth_models.dart';
import 'package:glint/services/models/address_models.dart';
import 'package:glint/services/models/booking_models.dart';
import 'package:glint/services/models/common_models.dart';
import 'package:glint/services/models/payment_card_models.dart';
import 'package:glint/services/models/payment_models.dart';
import 'package:glint/services/models/promocode_models.dart';
import 'package:glint/services/models/service_vehicle_models.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late final ApiClient _apiClient;
  late final TokenStorage _tokenStorage;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _tokenStorage = TokenStorage();
    _apiClient = ApiClient(createDio());
    _isInitialized = true;
  }

  // Authentication Services
  Future<ApiResponse<LoginResponse>> login(LoginCommand command) async {
    try {
      final response = await _apiClient.login(command);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final loginData = data['data'] as Map<String, dynamic>;
        await _tokenStorage.saveTokens(
          accessToken: loginData['accessToken'] as String,
          refreshToken: loginData['refreshToken'] as String?,
        );
        return ApiResponse.success(LoginResponse.fromJson(loginData));
      } else {
        final errors = data['errors'] as List<dynamic>?;
        final errorMessage = errors?.isNotEmpty == true 
            ? errors!.first.toString() 
            : data['message'] as String? ?? 'Login failed';
        return ApiResponse.error(errorMessage);
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<LoginResponse>> socialLogin(SocialLoginCommand command) async {
    try {
      final response = await _apiClient.socialLogin(command);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final loginData = data['data'] as Map<String, dynamic>;
        await _tokenStorage.saveTokens(
          accessToken: loginData['accessToken'] as String,
          refreshToken: loginData['refreshToken'] as String?,
        );
        return ApiResponse.success(LoginResponse.fromJson(loginData));
      } else {
        final errors = data['errors'] as List<dynamic>?;
        final errorMessage = errors?.isNotEmpty == true 
            ? errors!.first.toString() 
            : data['message'] as String? ?? 'Social login failed';
        return ApiResponse.error(errorMessage);
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<RegisterResponse>> register(RegisterCommand command) async {
    try {
      final response = await _apiClient.register(command);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final registerData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(RegisterResponse.fromJson(registerData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Registration failed');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> verifyEmail(VerifyEmailCommand command) async {
    try {
      final response = await _apiClient.verifyEmail(command);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Email verification failed');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> resendVerification(ResendVerificationCodeCommand command) async {
    try {
      final response = await _apiClient.resendVerification(command);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to resend verification');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> forgotPassword(ForgotPasswordCommand command) async {
    try {
      final response = await _apiClient.forgotPassword(command);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to send reset email');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> resetPassword(ResetPasswordCommand command) async {
    try {
      final response = await _apiClient.resetPassword(command);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Password reset failed');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> logout() async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken != null) {
        await _apiClient.logout(LogoutCommand(refreshToken: refreshToken));
      }
      await _tokenStorage.clear();
      return ApiResponse.success(null);
    } catch (e) {
      await _tokenStorage.clear(); // Clear tokens even if logout fails
      return ApiResponse.error('Logout error: ${e.toString()}');
    }
  }

  // Profile Services
  Future<ApiResponse<UserProfile>> getProfile() async {
    try {
      final response = await _apiClient.getProfile();
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final profileData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(UserProfile.fromJson(profileData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get profile');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<UserProfile>> updateProfile(UpdateProfileRequest request) async {
    try {
      final response = await _apiClient.updateProfile(request);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final profileData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(UserProfile.fromJson(profileData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to update profile');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // Vehicle Services
  Future<ApiResponse<List<Vehicle>>> getVehicles({int? pageNumber, int? pageSize}) async {
    try {
      // Get current user ID from AuthService
      final authService = AuthService();
      final currentUser = authService.currentUser;
      
      if (currentUser?.id == null) {
        return ApiResponse.error('User not logged in');
      }
      
      final response = await _apiClient.getUserVehicles(
        currentUser!.id!,
        pageNumber,
        pageSize,
      );
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final dataObj = data['data'] as Map<String, dynamic>;
        final vehiclesData = dataObj['items'] as List<dynamic>;
        final vehicles = vehiclesData.map((v) => Vehicle.fromJson(v as Map<String, dynamic>)).toList();
        return ApiResponse.success(vehicles);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get vehicles');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<Vehicle>> createVehicle(CreateVehicleRequest request) async {
    try {
      final response = await _apiClient.createVehicle(request);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final vehicleData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(Vehicle.fromJson(vehicleData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to create vehicle');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<Vehicle>> updateVehicle(int id, UpdateVehicleRequest request) async {
    try {
      final response = await _apiClient.updateVehicle(id, request);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final vehicleData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(Vehicle.fromJson(vehicleData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to update vehicle');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> deleteVehicle(int id) async {
    try {
      final response = await _apiClient.deleteVehicle(id);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to delete vehicle');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> setDefaultVehicle(int id) async {
    try {
      final response = await _apiClient.setDefaultVehicle(id);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to set default vehicle');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // Address Services
  Future<ApiResponse<List<Address>>> getAddresses({int? pageNumber, int? pageSize}) async {
    try {
      final response = await _apiClient.getAddresses(pageNumber, pageSize);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final addressesData = data['data'] as List<dynamic>;
        final addresses = addressesData.map((a) => Address.fromJson(a as Map<String, dynamic>)).toList();
        return ApiResponse.success(addresses);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get addresses');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<Address>> createAddress(CreateAddressRequest request) async {
    try {
      final response = await _apiClient.createAddress(request);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final addressData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(Address.fromJson(addressData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to create address');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<Address>> updateAddress(int id, UpdateAddressRequest request) async {
    try {
      final response = await _apiClient.updateAddress(id, request);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final addressData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(Address.fromJson(addressData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to update address');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> deleteAddress(int id) async {
    try {
      final response = await _apiClient.deleteAddress(id);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to delete address');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> setDefaultAddress(int id) async {
    try {
      final response = await _apiClient.setDefaultAddress(id);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to set default address');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // Service Services
  Future<ApiResponse<List<CarWashService>>> getServices({int? pageNumber, int? pageSize}) async {
    try {
      final response = await _apiClient.getServices(pageNumber, pageSize);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final dataObj = data['data'] as Map<String, dynamic>;
        final servicesData = dataObj['items'] as List<dynamic>;
        final services = servicesData.map((s) => CarWashService.fromJson(s as Map<String, dynamic>)).toList();
        return ApiResponse.success(services);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get services');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }


  // Lookup Services
  Future<ApiResponse<List<CarBrand>>> getCarBrands() async {
    try {
      final response = await _apiClient.carBrands();
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final brandsData = data['data'] as List<dynamic>;
        final brands = brandsData.map((b) => CarBrand.fromJson(b as Map<String, dynamic>)).toList();
        return ApiResponse.success(brands);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get car brands');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<CarModel>>> getCarModels(int brandId) async {
    try {
      final response = await _apiClient.carModels(brandId);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final modelsData = data['data'] as List<dynamic>;
        final models = modelsData.map((m) => CarModel.fromJson(m as Map<String, dynamic>)).toList();
        return ApiResponse.success(models);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get car models');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<CarColor>>> getCarColors() async {
    try {
      final response = await _apiClient.carColors();
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final colorsData = data['data'] as List<dynamic>;
        final colors = colorsData.map((c) => CarColor.fromJson(c as Map<String, dynamic>)).toList();
        return ApiResponse.success(colors);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get car colors');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // Booking Services
  Future<ApiResponse<List<Booking>>> getBookings({int? pageNumber, int? pageSize}) async {
    try {
      final response = await _apiClient.getBookings(pageNumber, pageSize);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final bookingsData = data['data'] as List<dynamic>;
        final bookings = bookingsData.map((b) => Booking.fromJson(b as Map<String, dynamic>)).toList();
        return ApiResponse.success(bookings);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get bookings');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<Booking>> createBooking(CreateBookingRequest request) async {
    try {
      final response = await _apiClient.createBooking(request);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final bookingData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(Booking.fromJson(bookingData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to create booking');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<Booking>>> getActiveBookings({int? pageNumber, int? pageSize}) async {
    try {
      final response = await _apiClient.getActiveBookings(pageNumber, pageSize);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final bookingsData = data['data'] as List<dynamic>;
        final bookings = bookingsData.map((b) => Booking.fromJson(b as Map<String, dynamic>)).toList();
        return ApiResponse.success(bookings);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get active bookings');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<Booking>>> getBookingsHistory() async {
    try {
      final response = await _apiClient.getBookingsHistory();
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final bookingsData = data['data'] as List<dynamic>;
        final bookings = bookingsData.map((b) => Booking.fromJson(b as Map<String, dynamic>)).toList();
        return ApiResponse.success(bookings);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get booking history');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<Booking>> getBooking(int id) async {
    try {
      final response = await _apiClient.getBooking(id);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final bookingData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(Booking.fromJson(bookingData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get booking');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> cancelBooking(int id, CancelBookingRequest request) async {
    try {
      final response = await _apiClient.cancelBooking(id, request);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to cancel booking');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // Payment Card Services
  Future<ApiResponse<List<PaymentCard>>> getPaymentCards() async {
    try {
      final response = await _apiClient.getPaymentCards();
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final cardsData = data['data'] as List<dynamic>;
        final cards = cardsData.map((c) => PaymentCard.fromJson(c as Map<String, dynamic>)).toList();
        return ApiResponse.success(cards);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get payment cards');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<PaymentCard>> createPaymentCard(CreatePaymentCardRequest request) async {
    try {
      final response = await _apiClient.createPaymentCard(request);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final cardData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(PaymentCard.fromJson(cardData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to create payment card');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> deletePaymentCard(int id) async {
    try {
      final response = await _apiClient.deletePaymentCard(id);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to delete payment card');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> setDefaultPaymentCard(int id) async {
    try {
      final response = await _apiClient.setDefaultPaymentCard(id);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to set default payment card');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // Promocode Services
  Future<ApiResponse<PromocodeValidation>> validatePromocode(ValidatePromocodeRequest request) async {
    try {
      final response = await _apiClient.validatePromocode(request);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final validationData = data['data'] as Map<String, dynamic>;
        return ApiResponse.success(PromocodeValidation.fromJson(validationData));
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to validate promocode');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // File Upload Services
  Future<ApiResponse<String>> uploadProfilePicture(File file) async {
    try {
      final response = await _apiClient.uploadProfilePicture(file);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final fileUrl = data['data'] as String;
        return ApiResponse.success(fileUrl);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to upload profile picture');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<String>> uploadVehiclePhoto(int vehicleId, File file) async {
    try {
      final response = await _apiClient.uploadVehiclePhoto(vehicleId, file);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final fileUrl = data['data'] as String;
        return ApiResponse.success(fileUrl);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to upload vehicle photo');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<List<String>>> uploadBookingPhotos(int bookingId, List<File> files) async {
    try {
      final response = await _apiClient.uploadBookingPhotos(bookingId, files);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final fileUrls = (data['data'] as List<dynamic>).cast<String>();
        return ApiResponse.success(fileUrls);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to upload booking photos');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // Notification Services
  Future<ApiResponse<List<Notification>>> getNotifications({int? pageNumber, int? pageSize}) async {
    try {
      final response = await _apiClient.notifications(pageNumber, pageSize);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final notificationsData = data['data'] as List<dynamic>;
        final notifications = notificationsData.map((n) => Notification.fromJson(n as Map<String, dynamic>)).toList();
        return ApiResponse.success(notifications);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get notifications');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<int>> getUnreadNotificationsCount() async {
    try {
      final response = await _apiClient.unreadNotificationsCount();
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        final count = data['data'] as int;
        return ApiResponse.success(count);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to get unread count');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> markNotificationRead(int id) async {
    try {
      final response = await _apiClient.markNotificationRead(id);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to mark notification as read');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> markAllNotificationsRead() async {
    try {
      final response = await _apiClient.markAllNotificationsRead();
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to mark all notifications as read');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> deleteNotification(int id) async {
    try {
      final response = await _apiClient.deleteNotification(id);
      final data = response.data as Map<String, dynamic>;
      
      if (data['isSuccess'] == true) {
        return ApiResponse.success(null);
      } else {
        return ApiResponse.error(data['message'] as String? ?? 'Failed to delete notification');
      }
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  // Health Check
  Future<ApiResponse<Map<String, dynamic>>> healthCheck() async {
    try {
      final response = await _apiClient.health();
      final data = response.data as Map<String, dynamic>;
      return ApiResponse.success(data);
    } catch (e) {
      return ApiResponse.error('Health check failed: ${e.toString()}');
    }
  }
}

// Generic API Response wrapper
class ApiResponse<T> {
  final bool isSuccess;
  final T? data;
  final String? error;

  ApiResponse._({required this.isSuccess, this.data, this.error});

  factory ApiResponse.success(T data) => ApiResponse._(isSuccess: true, data: data);
  factory ApiResponse.error(String error) => ApiResponse._(isSuccess: false, error: error);
}
