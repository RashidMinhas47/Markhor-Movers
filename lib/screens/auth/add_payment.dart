import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markhor_movers/components/leading_title_text.dart';

class AddPaymentScreen extends StatefulWidget {
  static const String scr = '/AddPaymentScreen';
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          ),
          Row(
            children: [
              Container(
                color: Colors.red,
                height: 34,
                width: 34,
              ),
              LeadingTitleText("Credit or Debit Card"),
            ],
          )
        ],
      )),
    );
  }
}
