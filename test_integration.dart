// Test script to verify API integration
// Run this with: dart test_integration.dart

import 'dart:io';
import 'package:dio/dio.dart';

void main() async {
  print('🧪 Testing CarWash API Integration...\n');
  
  final dio = Dio();
  const baseUrl = 'https://localhost:5001';
  
  try {
    // Test 1: Health Check
    print('1. Testing Health Endpoint...');
    final healthResponse = await dio.get('$baseUrl/api/Health');
    print('✅ Health check passed: ${healthResponse.statusCode}');
    print('   Response: ${healthResponse.data}\n');
    
    // Test 2: Get Car Brands
    print('2. Testing Car Brands Endpoint...');
    final brandsResponse = await dio.get('$baseUrl/api/Lookups/car-brands');
    print('✅ Car brands endpoint working: ${brandsResponse.statusCode}');
    print('   Found ${(brandsResponse.data['data'] as List).length} car brands\n');
    
    // Test 3: Get Services
    print('3. Testing Services Endpoint...');
    final servicesResponse = await dio.get('$baseUrl/api/Services');
    print('✅ Services endpoint working: ${servicesResponse.statusCode}');
    print('   Found ${(servicesResponse.data['data'] as List).length} services\n');
    
    // Test 4: Test Authentication (without credentials)
    print('4. Testing Authentication Endpoint...');
    try {
      final authResponse = await dio.post('$baseUrl/api/Auth/login', data: {
        'email': 'test@example.com',
        'password': 'wrongpassword'
      });
      print('✅ Auth endpoint accessible: ${authResponse.statusCode}');
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 400) {
        print('✅ Auth endpoint working (expected 400 for invalid credentials)');
      } else {
        print('❌ Auth endpoint error: $e');
      }
    }
    
    print('\n🎉 All basic API tests passed!');
    print('The Flutter app should be able to connect to the API successfully.');
    
  } catch (e) {
    print('❌ API connection failed: $e');
    print('\nTroubleshooting:');
    print('1. Make sure the .NET API is running on https://localhost:5001');
    print('2. Check if the API is accessible in your browser');
    print('3. Verify SSL certificates are working');
    print('4. Check firewall settings');
  }
}
