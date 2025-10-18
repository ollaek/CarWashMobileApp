import 'package:glint/services/service_locator.dart';
import 'package:glint/services/api_service.dart';
import 'package:glint/services/models/booking_models.dart';
import 'package:glint/services/models/service_vehicle_models.dart';

class BookingService {
  static final BookingService _instance = BookingService._internal();
  factory BookingService() => _instance;
  BookingService._internal();

  final ApiService _apiService = ServiceLocator().apiService;

  Future<ApiResponse<List<Booking>>> getBookings({int? pageNumber, int? pageSize}) async {
    return await _apiService.getBookings(pageNumber: pageNumber, pageSize: pageSize);
  }

  Future<ApiResponse<Booking>> createBooking({
    required int serviceId,
    required int vehicleId,
    required int addressId,
    required DateTime scheduledDateTime,
    required PaymentMethod paymentMethod,
    int? paymentCardId,
    String? promocodeCode,
    String? notes,
  }) async {
    final request = CreateBookingRequest(
      serviceId: serviceId,
      vehicleId: vehicleId,
      addressId: addressId,
      scheduledDateTime: scheduledDateTime.toIso8601String(),
      paymentMethod: paymentMethod,
      paymentCardId: paymentCardId,
      promocodeCode: promocodeCode,
      notes: notes,
    );
    
    return await _apiService.createBooking(request);
  }

  Future<ApiResponse<List<Booking>>> getActiveBookings({int? pageNumber, int? pageSize}) async {
    return await _apiService.getActiveBookings(pageNumber: pageNumber, pageSize: pageSize);
  }

  Future<ApiResponse<List<Booking>>> getBookingsHistory() async {
    return await _apiService.getBookingsHistory();
  }

  Future<ApiResponse<Booking>> getBooking(int id) async {
    return await _apiService.getBooking(id);
  }

  Future<ApiResponse<void>> cancelBooking(int id, {String? reason}) async {
    final request = CancelBookingRequest(reason: reason);
    return await _apiService.cancelBooking(id, request);
  }

  Future<ApiResponse<List<CarWashService>>> getServices({int? pageNumber, int? pageSize}) async {
    return await _apiService.getServices(pageNumber: pageNumber, pageSize: pageSize);
  }
}
