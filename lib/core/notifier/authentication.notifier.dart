import 'package:androidstudio_flutter/core/service/authentication.service.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationNotifier extends ChangeNotifier{

  final AuthenticationService _authenticationService =new AuthenticationService();
  Future<String?> signup({
    required BuildContext context,
    required String email,
    required String password,
    required String Enroll,
    required String name,
    required String Mobilenumber,

  })async {
    try {
      await _authenticationService.signup(password: password,email: email,context: context,Enroll:Enroll,name:name,Mobilenumber: Mobilenumber);

    } catch (e) {
      print(e);
    }
  }
  Future<String?> login({
    required BuildContext context,
    required String email,
    required String password,
  })async {
    try {
      await _authenticationService.login(context: context,email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  }
