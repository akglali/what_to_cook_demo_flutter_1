import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/userinfo.profile',
    'https://www.googleapis.com/auth/contacts.readonly',
    'openid',
  ]);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn( );

  static Future<GoogleSignInAccount?> logout() => _googleSignIn.disconnect();
}
