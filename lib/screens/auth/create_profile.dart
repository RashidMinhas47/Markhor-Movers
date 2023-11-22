import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:markhor_movers/components/info_text_field.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/repositories/auth_repositories.dart';
import 'package:markhor_movers/screens/auth/add_payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/auth_button.dart';

class CreateProfile extends StatefulWidget {
  static const String scr = "/CreateProfile";
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();

  Future<Map<String, dynamic>> getDefaultData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firstNameCont.text = prefs.getString(NAMEKEY)!.split(' ').elementAt(0);
    lastNameCont.text = prefs.getString(NAMEKEY)!.split(' ').elementAt(1);
    return {
      NAMEKEY: prefs.getString(NAMEKEY),
      IMAGEURLKEY: prefs.getString(IMAGEURLKEY),
    };
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LeadingTitleText(
            "What's your name?",
            fontSize: 18,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              children: [
                InfoTextFeild(
                  hintText: 'First',
                  controller: firstNameCont,
                ),
                InfoTextFeild(
                  hintText: 'Last',
                  controller: lastNameCont,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Map<String, dynamic>>(
                  future: getDefaultData(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(snap.data![IMAGEURLKEY]),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          ),
          LeadingTitleText(
            "By tapping the arrow below, you agree to MARKHOR MOVERS Terms of Use and acknowledge that you have read the Privacy Policy",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: RichText(
              text: TextSpan(
                text:
                    "Check the box to indicate that you are atleast 18 years of age, agree to the",
                children: [
                  TextSpan(
                    text: " Terms and Conditions",
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => TermsAndConditions(),
                        //   ),
                        // );
                      },
                  ),
                  TextSpan(
                      text: " and acknowledge the ",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      )),
                  TextSpan(
                    text: "Privacy Policy",
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => PrivacyAndPolicy(),
                        //   ),
                        // );
                      },
                  ),
                ],
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: AuthButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPaymentScreen.scr);
              },
              title: 'Next',
              size: Size(size.width * 0.9, 59),
            ),
          ),
        ],
      ),
    );
  }
}

const profileAwatar = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 70,
      child: Icon(
        Icons.person,
        size: 70,
      ),
    ),
  ],
);
