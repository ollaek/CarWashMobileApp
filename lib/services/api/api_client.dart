import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:glint/services/models/address_models.dart';
import 'package:glint/services/models/auth_models.dart';
import 'package:glint/services/models/booking_models.dart';
import 'package:glint/services/models/common_models.dart';
import 'package:glint/services/models/payment_card_models.dart';
import 'package:glint/services/models/payment_models.dart';
import 'package:glint/services/models/promocode_models.dart';
import 'package:glint/services/models/service_vehicle_models.dart';

part 'api_client.g.dart';

// Base API client with Retrofit annotations will be generated into api_client.g.dart
@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Addresses
  @GET('/api/Addresses')
  Future<HttpResponse<dynamic>> getAddresses(
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  );

  @POST('/api/Addresses')
  Future<HttpResponse<dynamic>> createAddress(
    @Body() CreateAddressRequest body,
  );

  @GET('/api/Addresses/{id}')
  Future<HttpResponse<dynamic>> getAddress(@Path('id') int id);

  @PUT('/api/Addresses/{id}')
  Future<HttpResponse<dynamic>> updateAddress(
    @Path('id') int id,
    @Body() UpdateAddressRequest body,
  );

  @DELETE('/api/Addresses/{id}')
  Future<HttpResponse<dynamic>> deleteAddress(@Path('id') int id);

  @PUT('/api/Addresses/{id}/set-default')
  Future<HttpResponse<dynamic>> setDefaultAddress(@Path('id') int id);

  // Auth
  @POST('/api/Auth/register')
  Future<HttpResponse<dynamic>> register(@Body() RegisterCommand body);

  @POST('/api/Auth/login')
  Future<HttpResponse<dynamic>> login(@Body() LoginCommand body);

  @POST('/api/Auth/verify-email')
  Future<HttpResponse<dynamic>> verifyEmail(@Body() VerifyEmailCommand body);

  @POST('/api/Auth/resend-verification-code')
  Future<HttpResponse<dynamic>> resendVerification(
    @Body() ResendVerificationCodeCommand body,
  );

  @POST('/api/Auth/forgot-password')
  Future<HttpResponse<dynamic>> forgotPassword(
    @Body() ForgotPasswordCommand body,
  );

  @POST('/api/Auth/reset-password')
  Future<HttpResponse<dynamic>> resetPassword(
    @Body() ResetPasswordCommand body,
  );

  @POST('/api/Auth/logout')
  Future<HttpResponse<dynamic>> logout(@Body() LogoutCommand body);

  @POST('/api/Auth/social-login')
  Future<HttpResponse<dynamic>> socialLogin(@Body() SocialLoginCommand body);

  // Bookings
  @GET('/api/Bookings')
  Future<HttpResponse<dynamic>> getBookings(
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  );

  @POST('/api/Bookings')
  Future<HttpResponse<dynamic>> createBooking(
    @Body() CreateBookingRequest body,
  );

  @GET('/api/Bookings/active')
  Future<HttpResponse<dynamic>> getActiveBookings(
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  );

  @GET('/api/Bookings/history')
  Future<HttpResponse<dynamic>> getBookingsHistory();

  @GET('/api/Bookings/{id}')
  Future<HttpResponse<dynamic>> getBooking(@Path('id') int id);

  @PUT('/api/Bookings/{id}/cancel')
  Future<HttpResponse<dynamic>> cancelBooking(
    @Path('id') int id,
    @Body() CancelBookingRequest body,
  );

  // FileUpload
  @POST('/api/FileUpload/profile-picture')
  @MultiPart()
  Future<HttpResponse<dynamic>> uploadProfilePicture(
    @Part(name: 'file') File file,
  );

  @POST('/api/FileUpload/vehicle-photo/{vehicleId}')
  @MultiPart()
  Future<HttpResponse<dynamic>> uploadVehiclePhoto(
    @Path('vehicleId') int vehicleId,
    @Part(name: 'file') File file,
  );

  @POST('/api/FileUpload/booking-photos/{bookingId}')
  @MultiPart()
  Future<HttpResponse<dynamic>> uploadBookingPhotos(
    @Path('bookingId') int bookingId,
    @Part(name: 'files') List<File> files,
  );

  @POST('/api/FileUpload/image')
  @MultiPart()
  Future<HttpResponse<dynamic>> uploadImage(
    @Query('folder') String? folder,
    @Part(name: 'file') File file,
  );

  @DELETE('/api/FileUpload/image')
  Future<HttpResponse<dynamic>> deleteImage(@Query('fileUrl') String? fileUrl);

  // Health
  @GET('/api/Health')
  Future<HttpResponse<dynamic>> health();

  // Lookups
  @GET('/api/Lookups/car-brands')
  Future<HttpResponse<dynamic>> carBrands();

  @GET('/api/Lookups/car-models/{brandId}')
  Future<HttpResponse<dynamic>> carModels(@Path('brandId') int brandId);

  @GET('/api/Lookups/car-colors')
  Future<HttpResponse<dynamic>> carColors();

  // Notifications
  @GET('/api/Notifications')
  Future<HttpResponse<dynamic>> notifications(
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  );

  @GET('/api/Notifications/unread-count')
  Future<HttpResponse<dynamic>> unreadNotificationsCount();

  @PUT('/api/Notifications/{id}/mark-as-read')
  Future<HttpResponse<dynamic>> markNotificationRead(@Path('id') int id);

  @PUT('/api/Notifications/mark-all-as-read')
  Future<HttpResponse<dynamic>> markAllNotificationsRead();

  @DELETE('/api/Notifications/{id}')
  Future<HttpResponse<dynamic>> deleteNotification(@Path('id') int id);

  // Payment Cards
  @GET('/api/PaymentCards')
  Future<HttpResponse<dynamic>> getPaymentCards();

  @POST('/api/PaymentCards')
  Future<HttpResponse<dynamic>> createPaymentCard(
    @Body() CreatePaymentCardRequest body,
  );

  @GET('/api/PaymentCards/{id}')
  Future<HttpResponse<dynamic>> getPaymentCard(@Path('id') int id);

  @DELETE('/api/PaymentCards/{id}')
  Future<HttpResponse<dynamic>> deletePaymentCard(@Path('id') int id);

  @PUT('/api/PaymentCards/{id}/set-default')
  Future<HttpResponse<dynamic>> setDefaultPaymentCard(@Path('id') int id);

  // Payments
  @POST('/api/Payments/paymob/callback')
  Future<HttpResponse<dynamic>> paymobCallback(@Body() PaymobCallbackData body);

  @GET('/api/Payments/paymob/response')
  Future<HttpResponse<dynamic>> paymobResponse(
    @Query('success') bool? success,
    @Query('order') int? order,
  );

  @GET('/api/Payments/status/{bookingId}')
  Future<HttpResponse<dynamic>> paymentStatus(@Path('bookingId') int bookingId);

  // Profile
  @GET('/api/Profile')
  Future<HttpResponse<dynamic>> getProfile();

  @PUT('/api/Profile')
  Future<HttpResponse<dynamic>> updateProfile(
    @Body() UpdateProfileRequest body,
  );

  @PUT('/api/Profile/profile-picture')
  Future<HttpResponse<dynamic>> updateProfilePicture(
    @Body() UpdateProfilePictureRequest body,
  );

  @DELETE('/api/Profile/profile-picture')
  Future<HttpResponse<dynamic>> deleteProfilePicture();

  // Promocodes
  @POST('/api/Promocodes/validate')
  Future<HttpResponse<dynamic>> validatePromocode(
    @Body() ValidatePromocodeRequest body,
  );

  // Services
  @GET('/api/Services')
  Future<HttpResponse<dynamic>> getServices(
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  );

  @POST('/api/Services')
  Future<HttpResponse<dynamic>> createService(
    @Body() CreateServiceCommand body,
  );

  // Settings
  @GET('/api/Settings/preferences')
  Future<HttpResponse<dynamic>> getPreferences();

  @PUT('/api/Settings/preferences')
  Future<HttpResponse<dynamic>> updatePreferences(
    @Body() UpdatePreferencesRequest body,
  );

  @POST('/api/Settings/change-password')
  Future<HttpResponse<dynamic>> changePassword(
    @Body() ChangePasswordRequest body,
  );

  @DELETE('/api/Settings/delete-account')
  Future<HttpResponse<dynamic>> deleteAccount(
    @Body() DeleteAccountRequest body,
  );

  @POST('/api/Settings/contact-support')
  Future<HttpResponse<dynamic>> contactSupport(
    @Body() ContactSupportRequest body,
  );

  // Vehicles
  @GET('/api/Vehicles')
  Future<HttpResponse<dynamic>> getAllVehicles(
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  );

  @GET('/api/Vehicles/user/{userId}')
  Future<HttpResponse<dynamic>> getUserVehicles(
    @Path('userId') int userId,
    @Query('PageNumber') int? pageNumber,
    @Query('PageSize') int? pageSize,
  );

  @POST('/api/Vehicles')
  Future<HttpResponse<dynamic>> createVehicle(
    @Body() CreateVehicleRequest body,
  );

  @GET('/api/Vehicles/{id}')
  Future<HttpResponse<dynamic>> getVehicle(@Path('id') int id);

  @PUT('/api/Vehicles/{id}')
  Future<HttpResponse<dynamic>> updateVehicle(
    @Path('id') int id,
    @Body() UpdateVehicleRequest body,
  );

  @DELETE('/api/Vehicles/{id}')
  Future<HttpResponse<dynamic>> deleteVehicle(@Path('id') int id);

  @PUT('/api/Vehicles/{id}/set-default')
  Future<HttpResponse<dynamic>> setDefaultVehicle(@Path('id') int id);
}
