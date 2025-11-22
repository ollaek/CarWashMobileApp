import 'package:json_annotation/json_annotation.dart';

part 'payment_card_models.g.dart';

@JsonSerializable()
class CreatePaymentCardRequest {
  CreatePaymentCardRequest({
    this.cardNumber,
    this.cardHolderName,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isDefault,
  });

  final String? cardNumber;
  final String? cardHolderName;
  final int expiryMonth;
  final int expiryYear;
  final bool isDefault;

  factory CreatePaymentCardRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentCardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePaymentCardRequestToJson(this);
}

@JsonSerializable()
class PaymentCard {
  PaymentCard({
    this.id,
    this.cardNumber,
    this.cardHolderName,
    this.expiryMonth,
    this.expiryYear,
    this.cardType,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? cardNumber;
  final String? cardHolderName;
  final int? expiryMonth;
  final int? expiryYear;
  final String? cardType;
  final bool? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory PaymentCard.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentCardToJson(this);
}











