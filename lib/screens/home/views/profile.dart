import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';
import 'package:markhor_movers/repositories/auth_repositories.dart';
import 'package:markhor_movers/screens/auth/check_user_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSceen extends ConsumerStatefulWidget {
  static const String scr = '/ProfileScreen';
  const ProfileSceen({super.key});

  @override
  ConsumerState<ProfileSceen> createState() => _ProfileSceenState();
}

class _ProfileSceenState extends ConsumerState<ProfileSceen> {
  String userName = '';
  String userImage = '';
  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(NAMEKEY)!;
    userImage = prefs.getString(IMAGEURLKEY)!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
                      CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.person),
                      ),
                      Gap(20),
                      Text(
                        //TODO: THE NEXT WORK WILL DONE HERE
                        ref.read(authProvider).getCurrentUserName,
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Gap(20),
                  const Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Messages',
                            style: GoogleFonts.poppins(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
