import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markhor_movers/firebase_options.dart';
import 'package:markhor_movers/screens/auth/add_payment.dart';
import 'package:markhor_movers/screens/auth/check_user_status.dart';
import 'package:markhor_movers/screens/auth/create_profile.dart';
import 'package:markhor_movers/screens/auth/otp_screen.dart';
import 'package:markhor_movers/screens/home/home.dart';
import 'package:markhor_movers/screens/home/views/book_ride.dart';
import 'package:markhor_movers/screens/home/views/send_packae.dart';
import 'package:markhor_movers/screens/new_map.dart';
import 'package:markhor_movers/screens/home/views/profile.dart';
import 'package:markhor_movers/screens/riverpod_home.dart';

import 'screens/auth/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: UserStatus.scr,
      routes: {
        SignInScreen.scr: (context) => const SignInScreen(),
        OTPScreen.scr: (context) => const OTPScreen(),
        CreateProfile.scr: (context) => const CreateProfile(),
        AddPaymentScreen.scr: (context) => const AddPaymentScreen(),
        HomeScreen.scr: (context) => const HomeScreen(),
        RiverpodHome.scr: (context) => const RiverpodHome(),
        SendPackage.scr: (context) => const SendPackage(),
        BookRide.scr: (context) => const BookRide(),
        MapSample.scr: (context) => const MapSample(),
        ProfileSceen.scr: (context) => const ProfileSceen(),
        UserStatus.scr: (context) => const UserStatus(),
      },
    );
  }
}
