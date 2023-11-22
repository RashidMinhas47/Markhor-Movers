import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';
import 'package:markhor_movers/repositories/auth_repositories.dart';
import 'package:markhor_movers/screens/auth/check_user_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSceen extends StatefulWidget {
  static const String scr = '/ProfileScreen';
  const ProfileSceen({super.key});

  @override
  State<ProfileSceen> createState() => _ProfileSceenState();
}

class _ProfileSceenState extends State<ProfileSceen> {
  Future<String> getImageURL() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(IMAGEURLKEY).toString();
  }

  Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstName = prefs.get(NAMEKEY).toString().split(' ').first;
    String lastName = prefs.get(NAMEKEY).toString().split(' ').elementAt(2);
    return '$firstName $lastName';
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffolColor,
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: size.height * 0.3,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: kPrimaryColor),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder(
                          future: getImageURL(),
                          builder: (context, snap) {
                            if (snap.hasData) {
                              String imgURL = snap.data!;

                              return CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(imgURL),
                              );
                            } else if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              return Text('You Have got something');
                            }
                          }),
                      const Gap(20),
                      FutureBuilder(
                          future: getUserName(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                    ],
                  ),
                  const Gap(20),
                  const Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Text(
                      'Messages',
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ]),
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Trips',
                style: GoogleFonts.roboto(fontSize: 24, color: Colors.white),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Payment',
              style: GoogleFonts.roboto(fontSize: 24, color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Settings',
              style: GoogleFonts.roboto(fontSize: 24, color: Colors.white),
            ),
            onTap: () {
              AuthRepositories.gSignOut(context);
            },
          ),
        ],
      ),
    );
  }
}
