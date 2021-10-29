// ignore_for_file: avoid_print

import 'package:inject/inject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:appwrite_flutter/users.dart';

import 'home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    UserRepository _users = Inject().get<UserRepository>();

    try {
      var user = await _users.login(data.name, data.password);
      //TODO: include logic here after login
      return null;
    } catch (error) {
      print("login ERROR: $error");
      return error.toString().replaceFirst('AppwriteException: ', '');
    }
  }

  Future<String?> _signUpUser(LoginData data) async {
    UserRepository _users = Inject().get<UserRepository>();

    try {
      var newUser = await _users.register(data.name, data.name, data.password);

      try {
       var session = await _users.login(data.name, data.password);
        print("login after register OK");
       //TODO: include logic here after signUp

        return null;
      } catch (error) {
        print("login after register ERROR: $error");
        return error.toString().replaceFirst('AppwriteException: ', '');
      }
    } catch (error) {
      print("register ERROR: $error");
      return error.toString().replaceFirst('AppwriteException: ', '');
    }
  }

  Future<String?> _recoverPassword(String name) async {
    UserRepository _users = Inject().get<UserRepository>();
    print('Name: $name');
    try {
      dynamic response = await _users.recoverPassword(name);
      print("begin recoverPassword OK: $response");
      return null;
    } catch (error) {
      print("begin recoverPassword ERROR: $error");
      return error.toString().replaceFirst('AppwriteException: ', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: 'assets/images/logo.png',
      onLogin: _authUser,
      onSignup: _signUpUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>  HomeWidget(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
