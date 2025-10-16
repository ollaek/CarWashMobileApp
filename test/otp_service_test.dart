import 'package:flutter_test/flutter_test.dart';
import 'package:glint/services/otp_service.dart';

void main() {
  group('OtpService Tests', () {
    test('should generate a 6-digit OTP', () {
      final otp = OtpService.generateOtp();
      expect(otp.length, 6);
      expect(otp, isA<String>());
      expect(int.tryParse(otp), isNotNull);
    });

    test('should validate correct OTP', () {
      final otp = OtpService.generateOtp();
      final result = OtpService.validateOtp(otp);

      expect(result.isValid, true);
      expect(result.message, 'OTP verified successfully');
    });

    test('should reject incorrect OTP', () {
      OtpService.generateOtp();
      final result = OtpService.validateOtp('123456');

      expect(result.isValid, false);
      expect(result.message, 'Invalid OTP. Please try again.');
    });

    test('should reject OTP with wrong length', () {
      OtpService.generateOtp();
      final result = OtpService.validateOtp('12345');

      expect(result.isValid, false);
      expect(result.message, 'Please enter a 6-digit code');
    });

    test('should clear OTP after clearing', () {
      OtpService.generateOtp();
      OtpService.clearOtp();
      final result = OtpService.validateOtp('123456');

      expect(result.isValid, false);
      expect(result.message, 'No OTP found. Please request a new one.');
    });
  });
}
