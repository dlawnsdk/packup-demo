import 'package:flutter/material.dart';
import 'package:mob/Common/util.dart';
import 'package:mob/model/login_model.dart';

import 'package:mob/model/user_model.dart';
import 'package:mob/model/result_model.dart';
import 'package:mob/service/login_service.dart';

/// UserModel 구독
class UserViewModel extends ChangeNotifier {
  UserModel? _userModel;
  ResultModel? _resultModel;
  bool _isLoading = false;

  final LoginService _httpService = LoginService();

  UserModel? get userModel => _userModel;         // 회원 정보
  ResultModel? get resultModel => _resultModel;   // http 결과
  bool get isLoading => _isLoading;               // 로딩 상태 플래그

  // 로그인 시도
  Future<void> checkLogin(userId, password) async {
    _isLoading = true;
    notifyListeners(); // 로딩 상태 변경 감지

    try {

      Map<String, dynamic> loginModel = LoginModel(userId: userId, userPassword: password).toJson();

      _resultModel = await _httpService.checkLogin(loginModel);

      // 로그인 실패
      if(_resultModel?.statusCode == -1) {
        throw Exception("ERROR ${_resultModel?.message}");
      }
      // 로그인 성공
      else {
        // 로그인 성공 > 회원 정보 모델 셋
        _userModel = _resultModel?.response;
      }

    } catch (e) {
      logger(e.toString(), 'DEBUG');
    } finally {
      _isLoading = false;
      notifyListeners(); // 로그인 결과 변경 감지
    }
  }

  // 회원정보 조회
  Future<void> getUserInfo(seq) async {
    _isLoading = true;
    notifyListeners();

    try {
      Map<String, dynamic> data = {
        'seq': seq,
      };

      _resultModel = await _httpService.getUserInfo(data);

      if(_resultModel?.statusCode == -1) {
        throw Exception("ERROR ${_resultModel?.message}");
      }
      else {
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