import 'package:json_annotation/json_annotation.dart';

part 'promocode_models.g.dart';

@JsonSerializable()
class ValidatePromocodeRequest {
  ValidatePromocodeRequest({this.code, required this.orderAmount});

  final String? code;
  final double orderAmount;

  factory ValidatePromocodeRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidatePromocodeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ValidatePromocodeRequestToJson(this);
}

@JsonSerializable()
class PromocodeValidation {
  PromocodeValidation({
    this.isValid,
    this.discountAmount,
    this.discountPercentage,
    this.finalAmount,
    this.message,
  });

  final bool? isValid;
  final double? discountAmount;
  final double? discountPercentage;
  final double? finalAmount;
  final String? message;

  factory PromocodeValidation.fromJson(Map<String, dynamic> json) =>
      _$PromocodeValidationFromJson(json);
  Map<String, dynamic> toJson() => _$PromocodeValidationToJson(this);
}








