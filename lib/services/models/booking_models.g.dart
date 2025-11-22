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

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
  id: (json['id'] as num?)?.toInt(),
  serviceId: (json['serviceId'] as num?)?.toInt(),
  vehicleId: (json['vehicleId'] as num?)?.toInt(),
  addressId: (json['addressId'] as num?)?.toInt(),
  scheduledDateTime: json['scheduledDateTime'] == null
      ? null
      : DateTime.parse(json['scheduledDateTime'] as String),
  status: json['status'] as String?,
  paymentMethod: json['paymentMethod'] as String?,
  paymentCardId: (json['paymentCardId'] as num?)?.toInt(),
  promocodeCode: json['promocodeCode'] as String?,
  notes: json['notes'] as String?,
  basePrice: (json['basePrice'] as num?)?.toDouble(),
  discountAmount: (json['discountAmount'] as num?)?.toDouble(),
  finalPrice: (json['finalPrice'] as num?)?.toDouble(),
  service: json['service'] == null
      ? null
      : CarWashService.fromJson(json['service'] as Map<String, dynamic>),
  vehicle: json['vehicle'] == null
      ? null
      : Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
  address: json['address'] == null
      ? null
      : Address.fromJson(json['address'] as Map<String, dynamic>),
  paymentCard: json['paymentCard'] == null
      ? null
      : PaymentCard.fromJson(json['paymentCard'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
  'id': instance.id,
  'serviceId': instance.serviceId,
  'vehicleId': instance.vehicleId,
  'addressId': instance.addressId,
  'scheduledDateTime': instance.scheduledDateTime?.toIso8601String(),
  'status': instance.status,
  'paymentMethod': instance.paymentMethod,
  'paymentCardId': instance.paymentCardId,
  'promocodeCode': instance.promocodeCode,
  'notes': instance.notes,
  'basePrice': instance.basePrice,
  'discountAmount': instance.discountAmount,
  'finalPrice': instance.finalPrice,
  'service': instance.service,
  'vehicle': instance.vehicle,
  'address': instance.address,
  'paymentCard': instance.paymentCard,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
