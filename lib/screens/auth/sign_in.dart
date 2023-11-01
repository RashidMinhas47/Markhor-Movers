import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markhor_movers/components/auth_button.dart';
import 'package:markhor_movers/components/auth_text_field.dart';
import 'package:markhor_movers/screens/auth/otp_screen.dart';

import '../../components/icon_btn.dart';
import '../../components/leading_title_text.dart';
import '../../constants/colors_scheme.dart';
import '../../constants/image_urls.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String scr = '/SignInScreen';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _phoneNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffolColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LeadingTitleText(
            "Sign up",
            fontSize: 72,
            padding: EdgeInsets.only(
                left: 20, right: 20, top: size.height * 0.1, bottom: 30),
          ),
          AuthTextField(
              hintText: '3490319909',
              controller: _phoneNoController,
              prefixIconURL: personIcon),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Or connect with social",
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconBtn(googleIcon, onPressed: () {}),
              IconBtn(
                facebookIcon,
                iconColor: Colors.blue,
                onPressed: () {},
              ),
            ],
          ),
          const Spacer(),
          AuthButton(
              size: Size(size.width * 0.9, 59),
              onPressed: () {
                Navigator.pushNamed(context, OTPScreen.scr);
              },
              title: 'Next'),
          const SizedBox(
            height: 30,
          ),
        ],
      )),
    );
  }
}
