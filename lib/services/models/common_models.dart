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




