import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/main.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key, required this.changeLanguage});

  final void Function(Locale locale) changeLanguage;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return HomePage(changeLanguage: changeLanguage);
          } else {
            return AuthPage(changeLanguage: changeLanguage);
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
