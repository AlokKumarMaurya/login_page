import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController with ChangeNotifier
{
  var _googleSignIn=GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;


  login() async
  {
    this.googleSignInAccount=await _googleSignIn.signIn();
    notifyListeners();
  }


}
