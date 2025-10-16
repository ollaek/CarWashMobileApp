import 'package:flutter/material.dart';
import 'package:glint/services/otp_service.dart';
import 'package:glint/widgets/otp_input_field.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  bool _isLoading = false;
  int _resendTimer = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    // Generate OTP when screen loads
    _generateOtp();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendTimer = 30;
      _canResend = false;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        if (_resendTimer > 0) {
          setState(() {
            _resendTimer--;
          });
          _startResendTimer();
        } else {
          setState(() {
            _canResend = true;
          });
        }
      }
    });
  }

  void _onDigitChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _verifyOtp();
      }
    }
  }

  void _onDigitDeleted(int index) {
    if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _generateOtp() {
    final otp = OtpService.generateOtp();
    // In a real app, send this OTP via SMS/Email
    debugPrint('Generated OTP: $otp'); // For development purposes only
  }

  void _verifyOtp() {
    final otp = _controllers.map((controller) => controller.text).join();

    if (otp.length == 6) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call delay
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });

          final result = OtpService.validateOtp(otp);

          if (result.isValid) {
            _showSuccessDialog();
          } else {
            _showErrorDialog(result.message);
          }
        }
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Verification Successful!',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF0D4A58),
          ),
        ),
        content: const Text(
          'Your phone number has been verified successfully.',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Color(0xFF666666),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              OtpService.clearOtp(); // Clear OTP for security
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Text(
              'Continue',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFFFF6B35),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Verification Failed',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF0D4A58),
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Color(0xFF666666),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Clear all fields
              for (var controller in _controllers) {
                controller.clear();
              }
              _focusNodes[0].requestFocus();
            },
            child: const Text(
              'Try Again',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFFF05423),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resendOtp() {
    if (_canResend) {
      setState(() {
        _isLoading = true;
      });

      // Clear all fields
      for (var controller in _controllers) {
        controller.clear();
      }
      _focusNodes[0].requestFocus();

      // Generate new OTP
      _generateOtp();

      // Simulate resend API call
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          _startResendTimer();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'OTP sent successfully!',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: Color(0xFF0D4A58),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0D4A58)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Title
              const Text(
                'Enter Verification Code',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: Color(0xFF2F6F7A),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                'We\'ve sent a 6-digit code to your phone number',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Phone number display
              Text(
                '+20 ${widget.phoneNumber}',
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF0D4A58),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return OtpInputField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    onChanged: (value) => _onDigitChanged(value, index),
                    onDeleted: () => _onDigitDeleted(index),
                    isLast: index == 5,
                  );
                }),
              ),

              const SizedBox(height: 40),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF05423),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Continue',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // Resend OTP Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive the code? ',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (_canResend)
                    GestureDetector(
                      onTap: _resendOtp,
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFFF05423),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  else
                    Text(
                      'Resend in ${_resendTimer}s',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
