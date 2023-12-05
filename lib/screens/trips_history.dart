import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:markhor_movers/constants/constants.dart';

class YourTrips extends StatelessWidget {
  static const String scr = '/YourTrips';
  const YourTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final rides = FirebaseFirestore.instance
        .collection(RIDES)
        .doc(_auth.currentUser!.email)
        .collection(YOURRIDES);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Trips'),
      ),
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: rides.snapshots(),
              builder: (context, snapshot) {
                final getDocs = snapshot.data!.docs;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("SOMETHING IS WRONG");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => ListTile(
                        title: Text(
                            '${snapshot.data!.docs[index]['passengerName']}'),
                        trailing: Text('${getDocs[index]['pickupTime']}')),
                  );
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
