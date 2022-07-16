import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourism/frontpage.dart';
import 'package:tourism/login/auth_page.dart';

class LoginMainClass extends StatefulWidget {
  const LoginMainClass({Key? key}) : super(key: key);

  @override
  State<LoginMainClass> createState() => _LoginMainClassState();
}

class _LoginMainClassState extends State<LoginMainClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),builder: (context,
          snapshot)
          {
            if(snapshot.hasData)
              {
                return tourism();
              }
            else
              {
                return AuthPage();
              }
          }

      )
    );
  }
}
