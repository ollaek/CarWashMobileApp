import 'package:google_sign_in/google_sign_in.dart';
import 'package:glint/services/api_service.dart';
import 'package:glint/services/models/auth_models.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com', // Replace with your actual client ID
    scopes: [
      'email',
      'profile',
    ],
  );

  static GoogleSignIn get instance => _googleSignIn;

  /// Sign in with Google and return the ID token
  static Future<GoogleSignInResult?> signInWithGoogle() async {
    try {
      // First, sign out any existing user to ensure fresh login
      await _googleSignIn.signOut();
      
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      
      if (account == null) {
        return null; // User cancelled
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      
      if (auth.idToken == null) {
        throw Exception('Failed to get ID token from Google');
      }
      
      return GoogleSignInResult(
        idToken: auth.idToken!,
        email: account.email,
        fullName: account.displayName,
        profilePictureUrl: account.photoUrl,
      );
    } catch (e) {
      throw Exception('Google Sign-In failed: $e');
    }
  }

  /// Sign out from Google
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  /// Check if user is currently signed in to Google
  static Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  /// Get current Google user
  static Future<GoogleSignInAccount?> getCurrentUser() async {
    return await _googleSignIn.signInSilently();
  }
}

class GoogleSignInResult {
  final String idToken;
  final String? email;
  final String? fullName;
  final String? profilePictureUrl;

  GoogleSignInResult({
    required this.idToken,
    this.email,
    this.fullName,
    this.profilePictureUrl,
  });
}
