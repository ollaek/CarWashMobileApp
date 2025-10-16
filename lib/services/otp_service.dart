import 'dart:math';

class OtpService {
  static const int _otpLength = 6;
  static const int _otpExpiryMinutes = 5;

  // In a real app, this would be stored securely and validated against backend
  static String? _currentOtp;
  static DateTime? _otpGeneratedTime;

  /// Generates a random 6-digit OTP
  static String generateOtp() {
    final random = Random();
    final otp = List.generate(_otpLength, (index) => random.nextInt(10)).join();
    _currentOtp = otp;
    _otpGeneratedTime = DateTime.now();
    return otp;
  }

  /// Validates the entered OTP
  static OtpValidationResult validateOtp(String enteredOtp) {
    if (enteredOtp.length != _otpLength) {
      return OtpValidationResult(
        isValid: false,
        message: 'Please enter a 6-digit code',
      );
    }

    if (_currentOtp == null || _otpGeneratedTime == null) {
      return OtpValidationResult(
        isValid: false,
        message: 'No OTP found. Please request a new one.',
      );
    }

    // Check if OTP has expired
    final now = DateTime.now();
    final timeDifference = now.difference(_otpGeneratedTime!);
    if (timeDifference.inMinutes > _otpExpiryMinutes) {
      return OtpValidationResult(
        isValid: false,
        message: 'OTP has expired. Please request a new one.',
      );
    }

    if (enteredOtp == _currentOtp) {
      return OtpValidationResult(
        isValid: true,
        message: 'OTP verified successfully',
      );
    } else {
      return OtpValidationResult(
        isValid: false,
        message: 'Invalid OTP. Please try again.',
      );
    }
  }

  /// Clears the current OTP (useful for security)
  static void clearOtp() {
    _currentOtp = null;
    _otpGeneratedTime = null;
  }

  /// Gets remaining time in seconds for OTP expiry
  static int getRemainingTime() {
    if (_otpGeneratedTime == null) return 0;

    final now = DateTime.now();
    final timeDifference = now.difference(_otpGeneratedTime!);
    final remainingSeconds =
        (_otpExpiryMinutes * 60) - timeDifference.inSeconds;

    return remainingSeconds > 0 ? remainingSeconds : 0;
  }

  /// Checks if OTP is still valid (not expired)
  static bool isOtpValid() {
    return getRemainingTime() > 0;
  }
}

class OtpValidationResult {
  final bool isValid;
  final String message;

  const OtpValidationResult({required this.isValid, required this.message});
}
