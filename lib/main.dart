import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markhor_movers/components/auth_button.dart';
import 'package:markhor_movers/components/auth_text_field.dart';
import 'package:markhor_movers/components/icon_btn.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';
import 'package:markhor_movers/constants/image_urls.dart';
import 'package:markhor_movers/firebase_options.dart';
import 'package:markhor_movers/screens/auth/otp_screen.dart';

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
      },
    );
  }
}
