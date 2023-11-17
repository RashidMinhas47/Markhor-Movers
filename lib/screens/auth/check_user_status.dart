import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:markhor_movers/screens/auth/sign_in.dart';
import 'package:markhor_movers/screens/home/home.dart';

class UserStatus extends StatefulWidget {
  static const String scr = '/UserStatus';
  const UserStatus({super.key});

  @override
  State<UserStatus> createState() => _UserStatusState();
}

class _UserStatusState extends State<UserStatus> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return _auth.currentUser != null ? HomeScreen() : SignInScreen();
  }
}
