import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:markhor_movers/constants/constants.dart';
import 'package:markhor_movers/screens/auth/check_user_status.dart';
import 'package:markhor_movers/screens/auth/create_profile.dart';
import 'package:markhor_movers/screens/auth/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepositories extends ChangeNotifier {
  String _currentUserImage = '';
  String _currentUserName = 'Rashid Minhas';
  get getCurrentUserName => _currentUserName;
  get getCurrentUserImage => _currentUserImage;

  set currentUserImage(userImage) => _currentUserImage = userImage;
  // String? currentUserEmail;
  // String? currentUserId;
  String _phoneNumber = '';
  String _code = '';
  String get getPhoneNum => _phoneNumber;
  String get getCode => _code;
  set setCode(String newCode) => _code = newCode;
  final _auth = FirebaseAuth.instance;
  static Future<void> googleSignOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAuthentication googleSignInAuthentication;
    try {
      await googleSignIn.signOut();
      await googleSignIn.disconnect();
      print('.................USER SIGNING SUCCESSFULLY');
    } catch (e) {
      print(e);
    }
  }

  static gSignOut(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    _auth.signOut();
    final gAccount = GoogleSignIn();
    gAccount.signOut();
    gAccount.disconnect();
    Navigator.pushNamed(context, UserStatus.scr);
  }

  setUserCredential(String userImg, userName) {
    _currentUserImage = userImg;
    _currentUserName = userName;
  }

  googleSignin(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    if (credential != null) {
      prefs.setString(IMAGEURLKEY, gUser.photoUrl!);
      prefs.setString(EMAILKEY, gUser.email);
      prefs.setString(NAMEKEY, gUser.displayName!);
      setUserCredential(
          prefs.getString(IMAGEURLKEY)!, prefs.getString(NAMEKEY));
      final cloudFirestore = FirebaseFirestore.instance;
      cloudFirestore.collection(USERS).add({
        'userName': gUser.displayName,
        'email': gUser.email,
        'photoURL': gUser.photoUrl,
        'userID': gUser.id
      });

      Navigator.pushNamed(context, CreateProfile.scr);
    }
    return await FirebaseAuth.instance.signInWithCredential(credential);
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

const String IMAGEURLKEY = 'IMAGEURLKEY';
const String NAMEKEY = 'NAMEKEY';
const String EMAILKEY = 'EMAILKEY';
