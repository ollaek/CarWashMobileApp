import 'package:json_annotation/json_annotation.dart';

part 'address_models.g.dart';

@JsonSerializable()
class CreateAddressRequest {
  CreateAddressRequest({
    this.name,
    this.street,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.fullAddress,
    this.latitude,
    this.longitude,
    required this.isDefault,
  });

  final String? name;
  final String? street;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final String? fullAddress;
  final double? latitude;
  final double? longitude;
  final bool isDefault;

  factory CreateAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAddressRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAddressRequestToJson(this);
}

@JsonSerializable()
class UpdateAddressRequest {
  UpdateAddressRequest({
    this.name,
    this.street,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.fullAddress,
    this.latitude,
    this.longitude,
  });

  final String? name;
  final String? street;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final String? fullAddress;
  final double? latitude;
  final double? longitude;

  factory UpdateAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAddressRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateAddressRequestToJson(this);
}






