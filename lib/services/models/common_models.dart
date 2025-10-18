import 'package:json_annotation/json_annotation.dart';

part 'common_models.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  UpdateProfileRequest({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.countryCode,
  });

  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? countryCode;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}

@JsonSerializable()
class UpdateProfilePictureRequest {
  UpdateProfilePictureRequest({this.profileImageUrl});

  final String? profileImageUrl;

  factory UpdateProfilePictureRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfilePictureRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProfilePictureRequestToJson(this);
}

@JsonSerializable()
class ChangePasswordRequest {
  ChangePasswordRequest({this.currentPassword, this.newPassword});

  final String? currentPassword;
  final String? newPassword;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}

@JsonSerializable()
class DeleteAccountRequest {
  DeleteAccountRequest({this.password});

  final String? password;

  factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteAccountRequestToJson(this);
}

@JsonSerializable()
class ContactSupportRequest {
  ContactSupportRequest({this.subject, this.message});

  final String? subject;
  final String? message;

  factory ContactSupportRequest.fromJson(Map<String, dynamic> json) =>
      _$ContactSupportRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ContactSupportRequestToJson(this);
}

@JsonSerializable()
class UpdatePreferencesRequest {
  UpdatePreferencesRequest({
    required this.pushNotificationsEnabled,
    required this.locationPermissionEnabled,
    this.deviceToken,
    this.deviceType,
  });

  final bool pushNotificationsEnabled;
  final bool locationPermissionEnabled;
  final String? deviceToken;
  final String? deviceType;

  factory UpdatePreferencesRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePreferencesRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePreferencesRequestToJson(this);
}

@JsonSerializable()
class UserProfile {
  UserProfile({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.countryCode,
    this.profileImageUrl,
    this.isEmailVerified,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? countryCode;
  final String? profileImageUrl;
  final bool? isEmailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class LoginResponse {
  LoginResponse({
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.user,
  });

  final String? accessToken;
  final String? refreshToken;
  final int? expiresIn;
  final UserProfile? user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class RegisterResponse {
  RegisterResponse({
    this.userId,
    this.message,
    this.requiresEmailVerification,
  });

  final int? userId;
  final String? message;
  final bool? requiresEmailVerification;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class Notification {
  Notification({
    this.id,
    this.title,
    this.message,
    this.type,
    this.isRead,
    this.createdAt,
  });

  final int? id;
  final String? title;
  final String? message;
  final String? type;
  final bool? isRead;
  final DateTime? createdAt;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}








