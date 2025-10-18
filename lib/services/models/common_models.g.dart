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

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  id: (json['id'] as num?)?.toInt(),
  fullName: json['fullName'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  countryCode: json['countryCode'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
  isEmailVerified: json['isEmailVerified'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'countryCode': instance.countryCode,
      'profileImageUrl': instance.profileImageUrl,
      'isEmailVerified': instance.isEmailVerified,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      userId: (json['userId'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      isPhoneVerified: json['isPhoneVerified'] as bool?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'isEmailVerified': instance.isEmailVerified,
      'isPhoneVerified': instance.isPhoneVerified,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      userId: (json['userId'] as num?)?.toInt(),
      message: json['message'] as String?,
      requiresEmailVerification: json['requiresEmailVerification'] as bool?,
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'message': instance.message,
      'requiresEmailVerification': instance.requiresEmailVerification,
    };

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  message: json['message'] as String?,
  type: json['type'] as String?,
  isRead: json['isRead'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': instance.type,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
