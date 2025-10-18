# CarWash Mobile App - Integration Setup

## 🚀 Quick Start Guide

### Prerequisites
- .NET 8 SDK installed
- Flutter SDK installed
- Visual Studio or VS Code
- MySQL database (or SQL Server)

### Step 1: Start the .NET API Backend

1. **Navigate to the API directory:**
   ```bash
   cd CarWashApi/CarWash.Presentation
   ```

2. **Update the database connection string** in `appsettings.json`:
   ```json
   {
     "Database": {
       "Host": "localhost",
       "Port": "3306",
       "User": "root",
       "Password": "YourPassword",
       "Name": "CarWashDB"
     }
   }
   ```

3. **Run the API:**
   ```bash
   dotnet run
   ```

4. **Verify the API is running:**
   - Open browser: `https://localhost:5001/swagger`
   - You should see the Swagger UI with all available endpoints

### Step 2: Start the Flutter Mobile App

1. **Navigate to the Flutter app directory:**
   ```bash
   cd CarWashMobileApp
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate model classes:**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

### Step 3: Test the Integration

1. **Test API connectivity:**
   ```bash
   dart test_integration.dart
   ```

2. **Test in the app:**
   - Open the app
   - Try to login (you'll need to register first)
   - Check if services are loaded from the API
   - Test vehicle management features

## 🔧 Configuration

### API Configuration
The API base URL is set in `lib/services/api/api_config.dart`:
```dart
class ApiConfig {
  static const String baseUrl = 'https://localhost:5001';
}
```

### Database Setup
1. Create a MySQL database named `CarWashDB`
2. Update the connection string in `appsettings.json`
3. The API will automatically run migrations on startup

### SSL Certificate Issues
If you encounter SSL certificate issues:
1. Trust the development certificate
2. Or temporarily disable SSL verification in the Flutter app

## 📱 Testing the Integration

### 1. Authentication Flow
1. Open the app
2. Navigate to Sign In screen
3. Try to login with test credentials
4. Check console for API responses

### 2. Services Loading
1. Navigate to Home screen
2. Check if services are loaded from API
3. Verify the data matches what's in the database

### 3. Vehicle Management
1. Go to Vehicles screen
2. Try to add a new vehicle
3. Check if car brands/models are loaded from API

## 🐛 Troubleshooting

### Common Issues

#### 1. API Not Starting
- Check if port 5001 is available
- Verify .NET SDK is installed
- Check database connection string

#### 2. Flutter App Not Connecting
- Verify API is running on https://localhost:5001
- Check network connectivity
- Verify SSL certificates

#### 3. Database Issues
- Ensure MySQL is running
- Check connection string
- Verify database exists

#### 4. Code Generation Issues
- Run `flutter clean`
- Run `flutter pub get`
- Run build_runner again

### Debug Steps

1. **Check API Health:**
   ```bash
   curl https://localhost:5001/api/Health
   ```

2. **Check Flutter Console:**
   - Look for network error messages
   - Check API response logs

3. **Use Swagger UI:**
   - Test endpoints directly
   - Verify request/response formats

4. **Network Debugging:**
   - Use browser dev tools
   - Check network tab for failed requests

## 📋 Next Steps

1. **Complete UI Integration:**
   - Update all screens to use real API data
   - Add loading states and error handling

2. **Add Offline Support:**
   - Cache data locally
   - Handle offline scenarios

3. **Implement Push Notifications:**
   - Configure Firebase
   - Add notification handling

4. **Add Testing:**
   - Unit tests for services
   - Integration tests for API calls

## 📞 Support

If you encounter issues:
1. Check the console logs
2. Verify API is accessible in browser
3. Test endpoints with Swagger UI
4. Check network connectivity
5. Review the API integration guide

## 🎯 Success Criteria

The integration is successful when:
- ✅ API starts without errors
- ✅ Flutter app connects to API
- ✅ Authentication works
- ✅ Services are loaded from API
- ✅ Vehicle management works
- ✅ Booking creation works
- ✅ No console errors

## 📚 Additional Resources

- [Flutter HTTP Documentation](https://docs.flutter.dev/cookbook/networking/fetch-data)
- [Dio Package Documentation](https://pub.dev/packages/dio)
- [.NET Core API Documentation](https://docs.microsoft.com/en-us/aspnet/core/web-api/)
- [Entity Framework Documentation](https://docs.microsoft.com/en-us/ef/)
