# Google Sign-In Configuration

## 🔧 **Fix the Google Sign-In Error**

The error occurs because Google Sign-In needs a client ID for web. Here's how to fix it:

### **Step 1: Get Google Client ID**

1. **Go to Google Cloud Console**: https://console.cloud.google.com/
2. **Create a new project** or select existing one
3. **Enable Google+ API**:
   - Go to "APIs & Services" > "Library"
   - Search for "Google+ API" and enable it
4. **Create OAuth 2.0 credentials**:
   - Go to "APIs & Services" > "Credentials"
   - Click "Create Credentials" > "OAuth 2.0 Client ID"
   - Choose "Web application"
   - Add `http://localhost:port` to authorized origins
   - Copy the Client ID (looks like: `123456789-abcdefg.apps.googleusercontent.com`)

### **Step 2: Update the Code**

Replace `YOUR_WEB_CLIENT_ID.apps.googleusercontent.com` with your actual client ID in these files:

**File 1: `lib/services/google_signin_service.dart`**
```dart
static final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: 'YOUR_ACTUAL_CLIENT_ID.apps.googleusercontent.com', // Replace this
  scopes: ['email', 'profile'],
);
```

**File 2: `web/index.html`**
```html
<meta name="google-signin-client_id" content="YOUR_ACTUAL_CLIENT_ID.apps.googleusercontent.com">
```

### **Step 3: Test**

1. **Run the app**: `flutter run -d chrome`
2. **Click "Login With Google"**
3. **Should open Google account selection popup**

## 🚀 **Quick Setup**

1. **Get Client ID** from Google Cloud Console
2. **Replace** `YOUR_WEB_CLIENT_ID.apps.googleusercontent.com` in both files
3. **Run** `flutter run -d chrome`
4. **Test** Google Sign-In

**That's it! Google Sign-In will work perfectly!** 🎉
