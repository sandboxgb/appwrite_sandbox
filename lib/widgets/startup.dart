import 'package:inject/inject.dart';
import 'package:logging_lite/logging.dart';
import 'package:flutter/material.dart';
import 'package:appwrite_flutter/users.dart';
import 'package:sandbox/configuration/injections.dart';
import 'home.dart';
import 'login.dart';

class StartupWidget extends StatelessWidget {

  StartupWidget({Key? key}) : super(key: key) {
    Inject().configureStartUpInjections();
  }

  Future<bool> isAuthenticated() async {
    UserRepository _users = Inject().get<UserRepository>();
    return _users.getCurrentUser()
        .then((user) {
      //TODO: include logic here when a user is authenticated.
      return true;

    }).catchError((onError) {
      logError("isAuthenticated(): $onError");
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAuthenticated(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        print(snapshot.connectionState);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            if (snapshot.data!) {
              return HomeWidget();
            } else {
              return const LoginScreen();
            }
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}
