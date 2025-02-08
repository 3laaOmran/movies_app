import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> Login() => googleSignIn.signIn();

  static Future logout() => googleSignIn.disconnect();
}
