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
