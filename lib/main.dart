import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:markhor_movers/firebase_options.dart';
import 'package:markhor_movers/screens/auth/add_payment.dart';
import 'package:markhor_movers/screens/auth/create_profile.dart';
import 'package:markhor_movers/screens/auth/otp_screen.dart';
import 'package:markhor_movers/screens/home/home.dart';

import 'screens/auth/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: SignInScreen.scr,
      routes: {
        SignInScreen.scr: (context) => const SignInScreen(),
        OTPScreen.scr: (context) => const OTPScreen(),
        CreateProfile.scr: (context) => const CreateProfile(),
        AddPaymentScreen.scr: (context) => const AddPaymentScreen(),
        HomeScreen.scr: (context) => const HomeScreen(),
      },
    );
  }
}
