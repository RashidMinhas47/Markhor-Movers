import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:gap/gap.dart';
import 'package:markhor_movers/constants/image_urls.dart';
import '../../../components/auth_button.dart';

class SendPackage extends StatelessWidget {
  static const String scr = '/SendPackage';
  const SendPackage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Gap(10),
              SvgPicture.asset(kPackage),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeadingTitleText(
                    'Send packgaes with\nConnect',
                    textAlign: TextAlign.left,
                    fontSize: 34,
                  ),
                  const Gap(20),
                  LeadingTitleText(
                    'Get it delivered in the time it takes to drive there',
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                  const Gap(10),
                  AuthButton(
                      size: Size(size.width * 0.9, 59),
                      onPressed: () {},
                      title: 'Send a package'),
                  const Gap(10),
                  AuthButton(
                      size: Size(size.width * 0.9, 59),
                      onPressed: () {},
                      title: 'Recieve a package'),
                  const Gap(10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
