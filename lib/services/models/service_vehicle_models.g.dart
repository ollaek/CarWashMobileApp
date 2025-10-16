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
