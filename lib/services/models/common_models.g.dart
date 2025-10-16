// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProfileRequest(
  fullName: json['fullName'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  countryCode: json['countryCode'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  UpdateProfileRequest instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'countryCode': instance.countryCode,
};

UpdateProfilePictureRequest _$UpdateProfilePictureRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProfilePictureRequest(
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$UpdateProfilePictureRequestToJson(
  UpdateProfilePictureRequest instance,
) => <String, dynamic>{'profileImageUrl': instance.profileImageUrl};

ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => ChangePasswordRequest(
  currentPassword: json['currentPassword'] as String?,
  newPassword: json['newPassword'] as String?,
);

Map<String, dynamic> _$ChangePasswordRequestToJson(
  ChangePasswordRequest instance,
) => <String, dynamic>{
  'currentPassword': instance.currentPassword,
  'newPassword': instance.newPassword,
};

DeleteAccountRequest _$DeleteAccountRequestFromJson(
  Map<String, dynamic> json,
) => DeleteAccountRequest(password: json['password'] as String?);

Map<String, dynamic> _$DeleteAccountRequestToJson(
  DeleteAccountRequest instance,
) => <String, dynamic>{'password': instance.password};

ContactSupportRequest _$ContactSupportRequestFromJson(
  Map<String, dynamic> json,
) => ContactSupportRequest(
  subject: json['subject'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$ContactSupportRequestToJson(
  ContactSupportRequest instance,
) => <String, dynamic>{
  'subject': instance.subject,
  'message': instance.message,
};

UpdatePreferencesRequest _$UpdatePreferencesRequestFromJson(
  Map<String, dynamic> json,
) => UpdatePreferencesRequest(
  pushNotificationsEnabled: json['pushNotificationsEnabled'] as bool,
  locationPermissionEnabled: json['locationPermissionEnabled'] as bool,
  deviceToken: json['deviceToken'] as String?,
  deviceType: json['deviceType'] as String?,
);

Map<String, dynamic> _$UpdatePreferencesRequestToJson(
  UpdatePreferencesRequest instance,
) => <String, dynamic>{
  'pushNotificationsEnabled': instance.pushNotificationsEnabled,
  'locationPermissionEnabled': instance.locationPermissionEnabled,
  'deviceToken': instance.deviceToken,
  'deviceType': instance.deviceType,
};
