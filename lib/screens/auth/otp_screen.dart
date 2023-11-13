import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markhor_movers/components/auth_button.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/screens/auth/create_profile.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});
  static const String scr = "/OTPScreen";
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LeadingTitleText(
            'Enter the 4-digit code sent to you at ',
            fontSize: 34,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          LeadingTitleText(
            '+92 3912830989',
            fontSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OTPField(size: size),
              OTPField(size: size),
              OTPField(size: size),
              OTPField(size: size)
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextButton(
              onPressed: () {},
              child: LeadingTitleText(
                'Resend Code',
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: AuthButton(
                size: Size(size.width * 0.9, 59),
                onPressed: () {
                  Navigator.pushNamed(context, CreateProfile.scr);
                },
                title: 'Next'),
          ),
          SizedBox(
            height: 30,
          )
        ],
      )),
    );
  }
}

class OTPField extends StatelessWidget {
  const OTPField({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.width * 0.18,
      width: size.width * 0.18,
      child: TextField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: GoogleFonts.poppins(fontSize: 39),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(245, 78, 78, 78),
          filled: true,
          hintText: '0',
          hintStyle: GoogleFonts.poppins(
            fontSize: 39,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
