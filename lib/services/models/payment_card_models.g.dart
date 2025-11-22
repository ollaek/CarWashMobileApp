// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePaymentCardRequest _$CreatePaymentCardRequestFromJson(
  Map<String, dynamic> json,
) => CreatePaymentCardRequest(
  cardNumber: json['cardNumber'] as String?,
  cardHolderName: json['cardHolderName'] as String?,
  expiryMonth: (json['expiryMonth'] as num).toInt(),
  expiryYear: (json['expiryYear'] as num).toInt(),
  isDefault: json['isDefault'] as bool,
);

Map<String, dynamic> _$CreatePaymentCardRequestToJson(
  CreatePaymentCardRequest instance,
) => <String, dynamic>{
  'cardNumber': instance.cardNumber,
  'cardHolderName': instance.cardHolderName,
  'expiryMonth': instance.expiryMonth,
  'expiryYear': instance.expiryYear,
  'isDefault': instance.isDefault,
};

PaymentCard _$PaymentCardFromJson(Map<String, dynamic> json) => PaymentCard(
  id: (json['id'] as num?)?.toInt(),
  cardNumber: json['cardNumber'] as String?,
  cardHolderName: json['cardHolderName'] as String?,
  expiryMonth: (json['expiryMonth'] as num?)?.toInt(),
  expiryYear: (json['expiryYear'] as num?)?.toInt(),
  cardType: json['cardType'] as String?,
  isDefault: json['isDefault'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PaymentCardToJson(PaymentCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardNumber': instance.cardNumber,
      'cardHolderName': instance.cardHolderName,
      'expiryMonth': instance.expiryMonth,
      'expiryYear': instance.expiryYear,
      'cardType': instance.cardType,
      'isDefault': instance.isDefault,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
