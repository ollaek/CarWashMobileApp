import 'package:json_annotation/json_annotation.dart';

part 'service_vehicle_models.g.dart';

@JsonSerializable()
class CreateServiceCommand {
  CreateServiceCommand({
    this.name,
    this.description,
    required this.price,
    required this.durationInMinutes,
  });

  final String? name;
  final String? description;
  final double price;
  final int durationInMinutes;

  factory CreateServiceCommand.fromJson(Map<String, dynamic> json) =>
      _$CreateServiceCommandFromJson(json);
  Map<String, dynamic> toJson() => _$CreateServiceCommandToJson(this);
}

@JsonSerializable()
class CreateVehicleRequest {
  CreateVehicleRequest({
    required this.carBrandId,
    required this.carModelId,
    required this.carColorId,
    this.licensePlateNumber,
    required this.yearOfManufacture,
    this.photoUrl,
    required this.isDefault,
  });

  final int carBrandId;
  final int carModelId;
  final int carColorId;
  final String? licensePlateNumber;
  final int yearOfManufacture;
  final String? photoUrl;
  final bool isDefault;

  factory CreateVehicleRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateVehicleRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateVehicleRequestToJson(this);
}

@JsonSerializable()
class UpdateVehicleRequest {
  UpdateVehicleRequest({
    required this.carBrandId,
    required this.carModelId,
    required this.carColorId,
    this.licensePlateNumber,
    required this.yearOfManufacture,
    this.photoUrl,
  });

  final int carBrandId;
  final int carModelId;
  final int carColorId;
  final String? licensePlateNumber;
  final int yearOfManufacture;
  final String? photoUrl;

  factory UpdateVehicleRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateVehicleRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateVehicleRequestToJson(this);
}




