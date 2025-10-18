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

@JsonSerializable()
class CarBrand {
  CarBrand({
    this.id,
    this.name,
    this.logoUrl,
  });

  final int? id;
  final String? name;
  final String? logoUrl;

  factory CarBrand.fromJson(Map<String, dynamic> json) =>
      _$CarBrandFromJson(json);
  Map<String, dynamic> toJson() => _$CarBrandToJson(this);
}

@JsonSerializable()
class CarModel {
  CarModel({
    this.id,
    this.name,
    this.carBrandId,
  });

  final int? id;
  final String? name;
  final int? carBrandId;

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}

@JsonSerializable()
class CarColor {
  CarColor({
    this.id,
    this.name,
    this.hexCode,
  });

  final int? id;
  final String? name;
  final String? hexCode;

  factory CarColor.fromJson(Map<String, dynamic> json) =>
      _$CarColorFromJson(json);
  Map<String, dynamic> toJson() => _$CarColorToJson(this);
}

@JsonSerializable()
class Vehicle {
  Vehicle({
    this.id,
    this.carBrandId,
    this.carModelId,
    this.carColorId,
    this.licensePlateNumber,
    this.yearOfManufacture,
    this.photoUrl,
    this.isDefault,
    this.carBrand,
    this.carModel,
    this.carColor,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? carBrandId;
  final int? carModelId;
  final int? carColorId;
  final String? licensePlateNumber;
  final int? yearOfManufacture;
  final String? photoUrl;
  final bool? isDefault;
  final CarBrand? carBrand;
  final CarModel? carModel;
  final CarColor? carColor;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}

@JsonSerializable()
class CarWashService {
  CarWashService({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationInMinutes,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String description;
  final double price;
  final int durationInMinutes;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CarWashService.fromJson(Map<String, dynamic> json) =>
      _$CarWashServiceFromJson(json);
  Map<String, dynamic> toJson() => _$CarWashServiceToJson(this);
}








