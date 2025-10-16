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




