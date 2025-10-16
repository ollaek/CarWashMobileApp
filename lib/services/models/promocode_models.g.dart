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
