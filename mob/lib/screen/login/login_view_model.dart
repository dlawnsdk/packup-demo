import 'package:flutter/material.dart';
import 'package:mob/Common/util.dart';
import 'package:mob/model/user_model.dart';
import 'package:mob/model/result_model.dart';
import 'package:mob/service/login/login_service.dart';
import 'package:mob/component/social_login_btn.dart';
import 'package:mob/service/login/google_login_service.dart';
import 'package:mob/service/login/kakao_login_service.dart';

import 'package:mob/service/login/social_login.dart';

/// UserModel 구독
class UserViewModel extends ChangeNotifier {

  UserModel? _userModel;
  ResultModel? _resultModel;
  bool _isLoading = false;

  final LoginService _httpService = LoginService();

  UserModel? get userModel => _userModel;
  ResultModel? get resultModel => _resultModel;
  bool get isLoading => _isLoading;

  // 로그인 시도 (Enum 타입을 직접 사용)
  Future<void> checkLogin(SocialLoginType type) async {
    _isLoading = true;
    notifyListeners();

    try {
      switch (type) {
        case SocialLoginType.kakao:
          SocialLogin kakaoLogin = KakaoLogin();
          await kakaoLogin.login();
          break;

        case SocialLoginType.google:
          SocialLogin googleLogin = GoogleLogin();
          await googleLogin.login();

          // GoogleSignInAuthentication? googleAuth = await googleLogin.getAuth();
          // print("ID Token: ${googleAuth?.idToken}");
          break;
      }

    } catch (e) {
      logger(e.toString(), 'DEBUG');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 회원정보 조회
  Future<void> getUserInfo(int seq) async {
    _isLoading = true;
    notifyListeners();

    try {
      Map<String, dynamic> data = {'seq': seq};

      _resultModel = await _httpService.getUserInfo(data);

      if (_resultModel?.statusCode == -1) {
        throw Exception("ERROR ${_resultModel?.message}");
      } else {
        _userModel = _resultModel?.response;
      }

    } catch (e) {
      logger(e.toString(), 'DEBUG');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
