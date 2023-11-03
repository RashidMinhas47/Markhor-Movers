import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markhor_movers/components/book_ride_btn.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';
import 'package:markhor_movers/constants/image_urls.dart';

class HomeScreen extends StatefulWidget {
  static const String scr = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffolColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: size.height * 0.4,
              width: size.width,
              color: kPrimaryColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LeadingTitleText(
                      'To find your pickup location automatically, turn on location services',
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Turn on location")),
                    )
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [RideBookBtn(), SizedBox(width: 20), RideBookBtn()],
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kDarkGreyColor),
              child: LeadingTitleText(
                'Enter pickup point',
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
              ),
            ),
            SvgPicture.asset(
              kMapPic,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
