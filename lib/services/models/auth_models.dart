import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class RegisterCommand {
  RegisterCommand({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.countryCode,
    this.password,
    this.confirmPassword,
  });

  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? countryCode;
  final String? password;
  final String? confirmPassword;

  factory RegisterCommand.fromJson(Map<String, dynamic> json) =>
      _$RegisterCommandFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterCommandToJson(this);
}

@JsonSerializable()
class LoginCommand {
  LoginCommand({this.email, this.password});

  final String? email;
  final String? password;

  factory LoginCommand.fromJson(Map<String, dynamic> json) =>
      _$LoginCommandFromJson(json);
  Map<String, dynamic> toJson() => _$LoginCommandToJson(this);
}

@JsonSerializable()
class VerifyEmailCommand {
  VerifyEmailCommand({this.email, this.code});

  final String? email;
  final String? code;

  factory VerifyEmailCommand.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailCommandFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyEmailCommandToJson(this);
}

@JsonSerializable()
class ResendVerificationCodeCommand {
  ResendVerificationCodeCommand({this.email});

  final String? email;

  factory ResendVerificationCodeCommand.fromJson(Map<String, dynamic> json) =>
      _$ResendVerificationCodeCommandFromJson(json);
  Map<String, dynamic> toJson() => _$ResendVerificationCodeCommandToJson(this);
}

@JsonSerializable()
class ForgotPasswordCommand {
  ForgotPasswordCommand({this.email});

  final String? email;

  factory ForgotPasswordCommand.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordCommandFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotPasswordCommandToJson(this);
}

@JsonSerializable()
class ResetPasswordCommand {
  ResetPasswordCommand({
    this.email,
    this.code,
    this.newPassword,
    this.confirmPassword,
  });

  final String? email;
  final String? code;
  final String? newPassword;
  final String? confirmPassword;

  factory ResetPasswordCommand.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordCommandFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordCommandToJson(this);
}

@JsonSerializable()
class LogoutCommand {
  LogoutCommand({this.refreshToken});

  final String? refreshToken;

  factory LogoutCommand.fromJson(Map<String, dynamic> json) =>
      _$LogoutCommandFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutCommandToJson(this);
}











