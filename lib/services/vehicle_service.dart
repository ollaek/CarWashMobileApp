import 'package:glint/services/service_locator.dart';
import 'package:glint/services/api_service.dart';
import 'package:glint/services/models/service_vehicle_models.dart';

class VehicleService {
  static final VehicleService _instance = VehicleService._internal();
  factory VehicleService() => _instance;
  VehicleService._internal();

  final ApiService _apiService = ServiceLocator().apiService;

  Future<ApiResponse<List<Vehicle>>> getVehicles({int? pageNumber, int? pageSize}) async {
    return await _apiService.getVehicles(pageNumber: pageNumber, pageSize: pageSize);
  }

  Future<ApiResponse<Vehicle>> createVehicle({
    required int carBrandId,
    required int carModelId,
    required int carColorId,
    String? licensePlateNumber,
    required int yearOfManufacture,
    String? photoUrl,
    required bool isDefault,
  }) async {
    final request = CreateVehicleRequest(
      carBrandId: carBrandId,
      carModelId: carModelId,
      carColorId: carColorId,
      licensePlateNumber: licensePlateNumber,
      yearOfManufacture: yearOfManufacture,
      photoUrl: photoUrl,
      isDefault: isDefault,
    );
    
    return await _apiService.createVehicle(request);
  }

  Future<ApiResponse<Vehicle>> updateVehicle({
    required int id,
    required int carBrandId,
    required int carModelId,
    required int carColorId,
    String? licensePlateNumber,
    required int yearOfManufacture,
    String? photoUrl,
  }) async {
    final request = UpdateVehicleRequest(
      carBrandId: carBrandId,
      carModelId: carModelId,
      carColorId: carColorId,
      licensePlateNumber: licensePlateNumber,
      yearOfManufacture: yearOfManufacture,
      photoUrl: photoUrl,
    );
    
    return await _apiService.updateVehicle(id, request);
  }

  Future<ApiResponse<void>> deleteVehicle(int id) async {
    return await _apiService.deleteVehicle(id);
  }

  Future<ApiResponse<void>> setDefaultVehicle(int id) async {
    return await _apiService.setDefaultVehicle(id);
  }

  Future<ApiResponse<List<CarBrand>>> getCarBrands() async {
    return await _apiService.getCarBrands();
  }

  Future<ApiResponse<List<CarModel>>> getCarModels(int brandId) async {
    return await _apiService.getCarModels(brandId);
  }

  Future<ApiResponse<List<CarColor>>> getCarColors() async {
    return await _apiService.getCarColors();
  }
}
