# CarWash Mobile App - Troubleshooting Guide

## 🚨 Common Issues and Solutions

### Issue 1: Login Button Not Calling API

**Symptoms:**
- Login button redirects to home without calling API
- No network requests visible in console
- No error messages

**Possible Causes:**
1. API service not properly initialized
2. Missing generated files (.g.dart)
3. API not running
4. Network connectivity issues

**Solutions:**

#### Step 1: Check if API is Running
```bash
# Test API directly in browser
https://localhost:5001/api/Health
```

#### Step 2: Run API Connection Test
```bash
cd CarWashMobileApp
dart test_api_connection.dart
```

#### Step 3: Check Generated Files
```bash
# Verify .g.dart files exist
ls lib/services/api/*.g.dart
ls lib/services/models/*.g.dart
```

#### Step 4: Regenerate Files
```bash
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### Step 5: Check Console Logs
Look for these debug messages in the console:
- `🔐 Login button clicked!`
- `🚀 Initializing AuthService...`
- `🌐 Calling API login...`
- `📡 API Response received:`

### Issue 2: API Connection Failed

**Symptoms:**
- Network error messages
- SSL certificate errors
- Connection timeout

**Solutions:**

#### SSL Certificate Issues
```dart
// In dio_provider.dart, add this to handle self-signed certificates
dio.options.validateStatus = (status) => true;
dio.options.connectTimeout = Duration(seconds: 30);
dio.options.receiveTimeout = Duration(seconds: 30);
```

#### Network Configuration
```dart
// In api_config.dart, try different URLs
class ApiConfig {
  static const String baseUrl = 'https://localhost:5001';  // HTTPS
  // OR
  static const String baseUrl = 'http://localhost:5000';   // HTTP
}
```

### Issue 3: Generated Files Missing

**Symptoms:**
- Compilation errors
- Missing .g.dart files
- Build failures

**Solutions:**

#### Regenerate All Files
```bash
flutter clean
flutter pub get
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### Check Dependencies
```yaml
# In pubspec.yaml, ensure these are present:
dependencies:
  dio: ^5.7.0
  retrofit: ^4.4.1
  json_annotation: ^4.9.0
  shared_preferences: ^2.2.3

dev_dependencies:
  build_runner: ^2.4.13
  retrofit_generator: ^9.1.5
  json_serializable: ^6.8.0
```

### Issue 4: API Service Not Initialized

**Symptoms:**
- ServiceLocator not initialized error
- Null pointer exceptions
- API calls not working

**Solutions:**

#### Check Service Locator Initialization
```dart
// In main.dart, ensure this is called:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().initialize();  // This line is crucial
  runApp(const MyApp());
}
```

#### Debug Service Initialization
```dart
// Add this to ApiService.initialize()
Future<void> initialize() async {
  if (_isInitialized) return;
  
  print('🔧 Initializing ApiService...');
  _tokenStorage = TokenStorage();
  _apiClient = ApiClient(createDio());
  _isInitialized = true;
  print('✅ ApiService initialized successfully');
}
```

## 🔧 Debug Steps

### Step 1: Use Debug Login Screen
The app now starts with a debug login screen that shows:
- Real-time debug logs
- API call progress
- Error messages
- Response data

### Step 2: Check API Test Screen
Navigate to the API test screen to verify:
- API connectivity
- Endpoint availability
- Response formats

### Step 3: Console Debugging
Look for these debug messages:
```
🔐 Login button clicked!
📧 Email: user@example.com
🔑 Password: password123
🚀 Initializing AuthService...
📝 LoginCommand created: {email: user@example.com, password: password123}
🌐 Calling _apiService.login...
🌐 ApiService.login called
📝 Command: {email: user@example.com, password: password123}
🚀 Making API call to login endpoint...
📡 Raw API response received:
   Status Code: 200
   Data: {isSuccess: true, data: {...}}
✅ API returned success
🔑 Saving tokens...
✅ Tokens saved successfully
📡 AuthService received response:
   Success: true
   Error: null
   Data: LoginResponse(...)
👤 Current user set: user@example.com
✅ Login successful! Navigating to home...
```

### Step 4: Network Debugging
Use browser dev tools or network inspector to check:
- API requests are being made
- Request headers and body
- Response status and data
- SSL certificate validity

## 🚀 Quick Fixes

### Fix 1: Reset Everything
```bash
# Clean everything and start fresh
flutter clean
cd ..
rm -rf CarWashMobileApp/.dart_tool
cd CarWashMobileApp
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter run
```

### Fix 2: Check API Status
```bash
# Test API with curl
curl -k https://localhost:5001/api/Health
curl -k https://localhost:5001/api/Services
```

### Fix 3: Verify Dependencies
```bash
# Check if all packages are installed
flutter pub deps
```

### Fix 4: Check Network
```bash
# Test network connectivity
ping localhost
telnet localhost 5001
```

## 📱 Testing the Integration

### Test 1: API Connection
1. Start the .NET API: `dotnet run`
2. Open browser: `https://localhost:5001/swagger`
3. Test endpoints manually

### Test 2: Flutter App
1. Run the Flutter app
2. Use the debug login screen
3. Check console logs
4. Verify API calls are made

### Test 3: End-to-End
1. Register a new user via API
2. Login with those credentials in the app
3. Verify authentication works
4. Test other features

## 🆘 Still Having Issues?

### Check These Files:
1. `lib/services/api/api_config.dart` - API URL configuration
2. `lib/services/api/dio_provider.dart` - HTTP client setup
3. `lib/services/api_service.dart` - Main API service
4. `lib/services/auth_service.dart` - Authentication service
5. `lib/main.dart` - Service locator initialization

### Common Error Messages:
- `ServiceLocator not initialized` → Check main.dart initialization
- `Network error` → Check API is running and accessible
- `SSL certificate error` → Add certificate handling
- `Build failed` → Regenerate .g.dart files
- `Null pointer exception` → Check service initialization

### Debug Commands:
```bash
# Check Flutter doctor
flutter doctor

# Check dependencies
flutter pub deps

# Clean and rebuild
flutter clean && flutter pub get

# Regenerate files
flutter packages pub run build_runner build --delete-conflicting-outputs

# Run with verbose logging
flutter run --verbose
```

## 📞 Getting Help

If you're still having issues:
1. Check the console logs for specific error messages
2. Verify the API is running and accessible
3. Test the API endpoints manually
4. Check network connectivity
5. Verify all dependencies are installed
6. Try the debug screens provided

The debug login screen will show you exactly what's happening during the login process, making it easier to identify where the issue is occurring.
