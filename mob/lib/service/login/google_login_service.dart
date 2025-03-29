import 'package:google_sign_in/google_sign_in.dart';
import 'package:mob/service/login/social_login.dart';

class GoogleLogin implements SocialLogin {

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  late final GoogleSignInAccount? googleUser;

  @override
  Future<bool> login()  async {
    try {

      googleUser = await _googleSignIn.signIn();

      if(googleUser == null) {
        return false;
      }

      return true;
    } catch(error) {

      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {

      return true;
    } catch(error) {
      return false;
    }
  }

  @override
  Future<String?> getAccessToken()  async{
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    return googleAuth?.accessToken;
  }
}