// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAddressRequest _$CreateAddressRequestFromJson(
  Map<String, dynamic> json,
) => CreateAddressRequest(
  name: json['name'] as String?,
  street: json['street'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  zipCode: json['zipCode'] as String?,
  country: json['country'] as String?,
  fullAddress: json['fullAddress'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isDefault: json['isDefault'] as bool,
);

Map<String, dynamic> _$CreateAddressRequestToJson(
  CreateAddressRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'street': instance.street,
  'city': instance.city,
  'state': instance.state,
  'zipCode': instance.zipCode,
  'country': instance.country,
  'fullAddress': instance.fullAddress,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'isDefault': instance.isDefault,
};

UpdateAddressRequest _$UpdateAddressRequestFromJson(
  Map<String, dynamic> json,
) => UpdateAddressRequest(
  name: json['name'] as String?,
  street: json['street'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  zipCode: json['zipCode'] as String?,
  country: json['country'] as String?,
  fullAddress: json['fullAddress'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$UpdateAddressRequestToJson(
  UpdateAddressRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'street': instance.street,
  'city': instance.city,
  'state': instance.state,
  'zipCode': instance.zipCode,
  'country': instance.country,
  'fullAddress': instance.fullAddress,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
