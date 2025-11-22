// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promocode_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatePromocodeRequest _$ValidatePromocodeRequestFromJson(
  Map<String, dynamic> json,
) => ValidatePromocodeRequest(
  code: json['code'] as String?,
  orderAmount: (json['orderAmount'] as num).toDouble(),
);

Map<String, dynamic> _$ValidatePromocodeRequestToJson(
  ValidatePromocodeRequest instance,
) => <String, dynamic>{
  'code': instance.code,
  'orderAmount': instance.orderAmount,
};

PromocodeValidation _$PromocodeValidationFromJson(Map<String, dynamic> json) =>
    PromocodeValidation(
      isValid: json['isValid'] as bool?,
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      finalAmount: (json['finalAmount'] as num?)?.toDouble(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PromocodeValidationToJson(
  PromocodeValidation instance,
) => <String, dynamic>{
  'isValid': instance.isValid,
  'discountAmount': instance.discountAmount,
  'discountPercentage': instance.discountPercentage,
  'finalAmount': instance.finalAmount,
  'message': instance.message,
};
