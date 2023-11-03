import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markhor_movers/components/auth_button.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/constants/image_urls.dart';
import 'package:markhor_movers/screens/home/home.dart';

class AddPaymentScreen extends StatefulWidget {
  static const String scr = '/AddPaymentScreen';
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextButton(
                  onPressed: () {},
                  child: LeadingTitleText('do this later'.toUpperCase(),
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          LeadingTitleText(
            "Select your preferred payment method",
            fontSize: 18,
            fontWeight: FontWeight.w500,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          ),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset(kCardIcon),
            title: LeadingTitleText(
              "Credit or Debit Card",
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset(kCardIcon),
            title: LeadingTitleText(
              "JazzCash",
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset(kCardIcon),
            title: LeadingTitleText(
              "EasyPaisa",
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          AuthButton(
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.scr);
            },
            title: 'Next',
            size: Size(size.width * 0.9, 60),
          ),
          SizedBox(
            height: 20,
          )
        ],
      )),
    );
  }
}
