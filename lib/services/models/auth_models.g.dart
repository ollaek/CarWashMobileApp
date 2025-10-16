// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterCommand _$RegisterCommandFromJson(Map<String, dynamic> json) =>
    RegisterCommand(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      countryCode: json['countryCode'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$RegisterCommandToJson(RegisterCommand instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'countryCode': instance.countryCode,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };

LoginCommand _$LoginCommandFromJson(Map<String, dynamic> json) => LoginCommand(
  email: json['email'] as String?,
  password: json['password'] as String?,
);

Map<String, dynamic> _$LoginCommandToJson(LoginCommand instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

VerifyEmailCommand _$VerifyEmailCommandFromJson(Map<String, dynamic> json) =>
    VerifyEmailCommand(
      email: json['email'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$VerifyEmailCommandToJson(VerifyEmailCommand instance) =>
    <String, dynamic>{'email': instance.email, 'code': instance.code};

ResendVerificationCodeCommand _$ResendVerificationCodeCommandFromJson(
  Map<String, dynamic> json,
) => ResendVerificationCodeCommand(email: json['email'] as String?);

Map<String, dynamic> _$ResendVerificationCodeCommandToJson(
  ResendVerificationCodeCommand instance,
) => <String, dynamic>{'email': instance.email};

ForgotPasswordCommand _$ForgotPasswordCommandFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordCommand(email: json['email'] as String?);

Map<String, dynamic> _$ForgotPasswordCommandToJson(
  ForgotPasswordCommand instance,
) => <String, dynamic>{'email': instance.email};

ResetPasswordCommand _$ResetPasswordCommandFromJson(
  Map<String, dynamic> json,
) => ResetPasswordCommand(
  email: json['email'] as String?,
  code: json['code'] as String?,
  newPassword: json['newPassword'] as String?,
  confirmPassword: json['confirmPassword'] as String?,
);

Map<String, dynamic> _$ResetPasswordCommandToJson(
  ResetPasswordCommand instance,
) => <String, dynamic>{
  'email': instance.email,
  'code': instance.code,
  'newPassword': instance.newPassword,
  'confirmPassword': instance.confirmPassword,
};

LogoutCommand _$LogoutCommandFromJson(Map<String, dynamic> json) =>
    LogoutCommand(refreshToken: json['refreshToken'] as String?);

Map<String, dynamic> _$LogoutCommandToJson(LogoutCommand instance) =>
    <String, dynamic>{'refreshToken': instance.refreshToken};
