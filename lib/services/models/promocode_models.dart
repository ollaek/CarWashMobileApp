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






