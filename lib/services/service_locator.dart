import 'package:glint/services/api_service.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  late final ApiService _apiService;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _apiService = ApiService();
    await _apiService.initialize();
    _isInitialized = true;
  }

  ApiService get apiService {
    if (!_isInitialized) {
      throw Exception('ServiceLocator not initialized. Call initialize() first.');
    }
    return _apiService;
  }
}
