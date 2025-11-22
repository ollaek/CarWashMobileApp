// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_vehicle_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateServiceCommand _$CreateServiceCommandFromJson(
  Map<String, dynamic> json,
) => CreateServiceCommand(
  name: json['name'] as String?,
  description: json['description'] as String?,
  price: (json['price'] as num).toDouble(),
  durationInMinutes: (json['durationInMinutes'] as num).toInt(),
);

Map<String, dynamic> _$CreateServiceCommandToJson(
  CreateServiceCommand instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'durationInMinutes': instance.durationInMinutes,
};

CreateVehicleRequest _$CreateVehicleRequestFromJson(
  Map<String, dynamic> json,
) => CreateVehicleRequest(
  carBrandId: (json['carBrandId'] as num).toInt(),
  carModelId: (json['carModelId'] as num).toInt(),
  carColorId: (json['carColorId'] as num).toInt(),
  licensePlateNumber: json['licensePlateNumber'] as String?,
  yearOfManufacture: (json['yearOfManufacture'] as num).toInt(),
  photoUrl: json['photoUrl'] as String?,
  isDefault: json['isDefault'] as bool,
);

Map<String, dynamic> _$CreateVehicleRequestToJson(
  CreateVehicleRequest instance,
) => <String, dynamic>{
  'carBrandId': instance.carBrandId,
  'carModelId': instance.carModelId,
  'carColorId': instance.carColorId,
  'licensePlateNumber': instance.licensePlateNumber,
  'yearOfManufacture': instance.yearOfManufacture,
  'photoUrl': instance.photoUrl,
  'isDefault': instance.isDefault,
};

UpdateVehicleRequest _$UpdateVehicleRequestFromJson(
  Map<String, dynamic> json,
) => UpdateVehicleRequest(
  carBrandId: (json['carBrandId'] as num).toInt(),
  carModelId: (json['carModelId'] as num).toInt(),
  carColorId: (json['carColorId'] as num).toInt(),
  licensePlateNumber: json['licensePlateNumber'] as String?,
  yearOfManufacture: (json['yearOfManufacture'] as num).toInt(),
  photoUrl: json['photoUrl'] as String?,
);

Map<String, dynamic> _$UpdateVehicleRequestToJson(
  UpdateVehicleRequest instance,
) => <String, dynamic>{
  'carBrandId': instance.carBrandId,
  'carModelId': instance.carModelId,
  'carColorId': instance.carColorId,
  'licensePlateNumber': instance.licensePlateNumber,
  'yearOfManufacture': instance.yearOfManufacture,
  'photoUrl': instance.photoUrl,
};

CarBrand _$CarBrandFromJson(Map<String, dynamic> json) => CarBrand(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  logoUrl: json['logoUrl'] as String?,
);

Map<String, dynamic> _$CarBrandToJson(CarBrand instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
};

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  carBrandId: (json['carBrandId'] as num?)?.toInt(),
);

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'carBrandId': instance.carBrandId,
};

CarColor _$CarColorFromJson(Map<String, dynamic> json) => CarColor(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  hexCode: json['hexCode'] as String?,
);

Map<String, dynamic> _$CarColorToJson(CarColor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'hexCode': instance.hexCode,
};

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
  id: (json['id'] as num?)?.toInt(),
  carBrandId: (json['carBrandId'] as num?)?.toInt(),
  carModelId: (json['carModelId'] as num?)?.toInt(),
  carColorId: (json['carColorId'] as num?)?.toInt(),
  licensePlateNumber: json['licensePlateNumber'] as String?,
  yearOfManufacture: (json['yearOfManufacture'] as num?)?.toInt(),
  photoUrl: json['photoUrl'] as String?,
  isDefault: json['isDefault'] as bool?,
  carBrand: json['carBrand'] == null
      ? null
      : CarBrand.fromJson(json['carBrand'] as Map<String, dynamic>),
  carModel: json['carModel'] == null
      ? null
      : CarModel.fromJson(json['carModel'] as Map<String, dynamic>),
  carColor: json['carColor'] == null
      ? null
      : CarColor.fromJson(json['carColor'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
  'id': instance.id,
  'carBrandId': instance.carBrandId,
  'carModelId': instance.carModelId,
  'carColorId': instance.carColorId,
  'licensePlateNumber': instance.licensePlateNumber,
  'yearOfManufacture': instance.yearOfManufacture,
  'photoUrl': instance.photoUrl,
  'isDefault': instance.isDefault,
  'carBrand': instance.carBrand,
  'carModel': instance.carModel,
  'carColor': instance.carColor,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

CarWashService _$CarWashServiceFromJson(Map<String, dynamic> json) =>
    CarWashService(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      durationInMinutes: (json['durationInMinutes'] as num).toInt(),
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CarWashServiceToJson(CarWashService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'durationInMinutes': instance.durationInMinutes,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
