import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:markhor_movers/screens/auth/otp_screen.dart';

final authRepos = StateProvider<AuthRepositories>((ref) => AuthRepositories());
final codeRead = Provider((ref) {
  return ref.read(authRepos).getCode;
});

final class AuthRepositories {
  String _phoneNumber = '';
  String _code = '';
  String get getPhoneNum => _phoneNumber;
  String get getCode => _code;
  set setCode(String newCode) => _code = newCode;
  final _auth = FirebaseAuth.instance;
  void googleSignin() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAuthentication googleSignInAuthentication;
  }

  void signinWithPhone(
      {required phoneNum, required BuildContext context}) async {
    try {
      print(_phoneNumber);
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNum,
          verificationCompleted: (phoneAuthCred) {},
          verificationFailed: (variFaild) {},
          codeSent: (code, numb) {
            _code = code;
            print(
                '..............THIS IS CODE...............$code...............');
          },
          codeAutoRetrievalTimeout: (timeOut) {});
      Navigator.pushNamed(context, OTPScreen.scr);
    } catch (e) {
      print('...SOMETHING IS WRONG WITH THIS....');
    }
  }
}
