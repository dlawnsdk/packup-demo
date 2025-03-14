import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mob/screen/login/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mob/const/color.dart';
import 'package:mob/common/util.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _userIdErrorText = '';
  String _userPasswordErrorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: PRIMARY_COLOR,
        title: Text(
            AppLocalizations.of(context)!.login,
            style: TextStyle(color: TEXT_COLOR_W)
        ),
      ),
      body: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 아이디 입력 필드
                TextField(
                  controller: _userIdController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.id,
                    errorText: _userIdErrorText.isNotEmpty ? _userIdErrorText : null,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    errorText: _userPasswordErrorText.isNotEmpty ? _userPasswordErrorText : null,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                ElevatedButton(
                  onPressed: () {
                    login(_userIdController.text, _passwordController.text, context, viewModel);
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                        AppLocalizations.of(context)!.login,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: TEXT_COLOR_W),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.02),

                // 회원가입 버튼
                ElevatedButton(
                  onPressed: () {
                    context.go('/join');
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      AppLocalizations.of(context)!.join,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: TEXT_COLOR_W),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  login(String userId, String password, BuildContext context, UserViewModel viewModel) async {
    // validation(userId, password);

    if (userId.isNotEmpty && password.isNotEmpty) {
      logger("로그인중입니다.");

      // await viewModel.checkLogin(userId, password);

      if (viewModel.resultModel?.statusCode == 1) {
          if (context.mounted) {
            context.push('/index');
          }
      } else {
        context.push('/index');
        // setState(() {
        //   _userIdErrorText = AppLocalizations.of(context)!.invalid_credentials;
        //   _userPasswordErrorText = AppLocalizations.of(context)!.invalid_credentials;
        // });
      }
    }
  }

  validation(String userId, String password) {
    setState(() {
      _userIdErrorText = userId.isEmpty ? AppLocalizations.of(context)!.empty_id : '';
      _userPasswordErrorText = password.isEmpty ? AppLocalizations.of(context)!.empty_password : '';
    });
  }
}
