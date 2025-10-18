import 'package:glint/services/service_locator.dart';
import 'package:glint/services/api_service.dart';
import 'package:glint/services/models/auth_models.dart';
import 'package:glint/services/models/common_models.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final ApiService _apiService = ServiceLocator().apiService;
  UserProfile? _currentUser;

  UserProfile? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<ApiResponse<LoginResponse>> login(String email, String password) async {
    try {
      final command = LoginCommand(email: email, password: password);
      final response = await _apiService.login(command);
      
      if (response.isSuccess && response.data != null) {
        // Create UserProfile from LoginResponse
        _currentUser = UserProfile(
          id: response.data!.userId,
          fullName: response.data!.fullName,
          email: response.data!.email,
          phoneNumber: response.data!.phoneNumber,
          isEmailVerified: response.data!.isEmailVerified,
        );
      }
      
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse<RegisterResponse>> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String confirmPassword,
  }) async {
    final command = RegisterCommand(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
      password: password,
      confirmPassword: confirmPassword,
    );
    
    return await _apiService.register(command);
  }

  Future<ApiResponse<void>> verifyEmail(String email, String code) async {
    final command = VerifyEmailCommand(email: email, code: code);
    return await _apiService.verifyEmail(command);
  }

  Future<ApiResponse<void>> resendVerification(String email) async {
    final command = ResendVerificationCodeCommand(email: email);
    return await _apiService.resendVerification(command);
  }

  Future<ApiResponse<void>> forgotPassword(String email) async {
    final command = ForgotPasswordCommand(email: email);
    return await _apiService.forgotPassword(command);
  }

  Future<ApiResponse<void>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final command = ResetPasswordCommand(
      email: email,
      code: code,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    
    return await _apiService.resetPassword(command);
  }

  Future<ApiResponse<void>> logout() async {
    final response = await _apiService.logout();
    if (response.isSuccess) {
      _currentUser = null;
    }
    return response;
  }

  Future<ApiResponse<UserProfile>> getProfile() async {
    final response = await _apiService.getProfile();
    if (response.isSuccess && response.data != null) {
      _currentUser = response.data;
    }
    return response;
  }

  Future<ApiResponse<UserProfile>> updateProfile({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? countryCode,
  }) async {
    final request = UpdateProfileRequest(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
    );
    
    final response = await _apiService.updateProfile(request);
    if (response.isSuccess && response.data != null) {
      _currentUser = response.data;
    }
    return response;
  }
}
