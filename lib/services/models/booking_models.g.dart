// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBookingRequest _$CreateBookingRequestFromJson(
  Map<String, dynamic> json,
) => CreateBookingRequest(
  serviceId: (json['serviceId'] as num).toInt(),
  vehicleId: (json['vehicleId'] as num).toInt(),
  addressId: (json['addressId'] as num).toInt(),
  scheduledDateTime: json['scheduledDateTime'] as String,
  paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
  paymentCardId: (json['paymentCardId'] as num?)?.toInt(),
  promocodeCode: json['promocodeCode'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$CreateBookingRequestToJson(
  CreateBookingRequest instance,
) => <String, dynamic>{
  'serviceId': instance.serviceId,
  'vehicleId': instance.vehicleId,
  'addressId': instance.addressId,
  'scheduledDateTime': instance.scheduledDateTime,
  'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
  'paymentCardId': instance.paymentCardId,
  'promocodeCode': instance.promocodeCode,
  'notes': instance.notes,
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.method1: 'method1',
  PaymentMethod.method2: 'method2',
  PaymentMethod.method3: 'method3',
};

CancelBookingRequest _$CancelBookingRequestFromJson(
  Map<String, dynamic> json,
) => CancelBookingRequest(reason: json['reason'] as String?);

Map<String, dynamic> _$CancelBookingRequestToJson(
  CancelBookingRequest instance,
) => <String, dynamic>{'reason': instance.reason};
