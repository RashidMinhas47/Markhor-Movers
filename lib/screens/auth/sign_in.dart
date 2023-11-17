import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:markhor_movers/components/auth_button.dart';
import 'package:markhor_movers/components/auth_text_field.dart';
import 'package:markhor_movers/repositories/auth_repositories.dart';
import 'package:markhor_movers/screens/auth/create_profile.dart';

import '../../components/icon_btn.dart';
import '../../components/leading_title_text.dart';
import '../../constants/colors_scheme.dart';
import '../../constants/image_urls.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});
  static const String scr = '/SignInScreen';
  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _phoneNoController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
            "Enter your mobile number",
            fontSize: 30,
            padding: EdgeInsets.only(
                left: 20, right: 20, top: size.height * 0.1, bottom: 30),
          ),
          AuthTextField(
            formKey: formKey,
            hintText: '3490319909',
            controller: _phoneNoController,
            prefixIconURL: kPersonIcon,
            validator: (value) {
              if (value!.length <= 9) {
                return 'Your phone number is not completed';
              } else if (value.isEmpty) {
                return 'Please enter the phone number';
              } else if (value.contains('3')) {
                return null;
              }
            },
          ),
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
              IconBtn(kGoogleIcon, onPressed: () {
                AuthRepositories().googleSignin(context);
              }),
              IconBtn(
                kFacebookIcon,
                iconColor: Colors.blue,
                onPressed: () {
                  AuthRepositories.googleSignOut();
                },
              ),
            ],
          ),
          const Spacer(),
          AuthButton(
              size: Size(size.width * 0.9, 59),
              onPressed: () {
                GoogleSignIn googleSignIn = GoogleSignIn();
                String email = googleSignIn.currentUser!.email;
                print('.........................email.....................');
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
