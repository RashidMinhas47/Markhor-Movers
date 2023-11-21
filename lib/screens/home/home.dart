import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:markhor_movers/components/book_ride_btn.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';
import 'package:markhor_movers/constants/image_urls.dart';
import 'package:markhor_movers/screens/home/views/book_ride.dart';
import 'package:markhor_movers/screens/home/views/send_packae.dart';
import 'package:markhor_movers/screens/home/views/profile.dart';
import 'package:markhor_movers/screens/riverpod_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  static const String scr = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> setName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.delayed(const Duration(seconds: 3)).whenComplete(
        () async => await prefs.setString('name', 'Rashid Minhas'));

    return prefs.get('name').toString();
  }

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
          onPressed: () {
            Navigator.pushNamed(context, ProfileSceen.scr);
          },
        ),
        backgroundColor: kPrimaryColor,
      ),
      //..
      body: Center(
        child: Column(
          children: [
            Container(
              height: size.height * 0.34,
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
                          onPressed: () {},
                          child: const Text("Turn on location")),
                    )
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RideBookBtn(
                  btnIcon: kRideIcon,
                  btnTitle: 'Rider',
                  onTap: () {
                    Navigator.pushNamed(context, BookRide.scr);
                  },
                ),
                const Gap(20),
                RideBookBtn(
                  btnIcon: kPackageIcon,
                  btnTitle: 'Package',
                  onTap: () {
                    Navigator.pushNamed(context, SendPackage.scr);
                  },
                )
              ],
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
            FutureBuilder(
                future: setName(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    String name = snap.data!;
                    return TextButton(
                        onPressed: () {},
                        child: LeadingTitleText(name ?? "You Got not data"));
                  } else if (snap.hasData) {
                    return Text(snap.error.toString());
                  } else if (snap.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return Text('You Have got something');
                  }
                }),
            const Gap(30),
            Image.asset(kAroundYou),
          ],
        ),
      ),
    );
  }
}
