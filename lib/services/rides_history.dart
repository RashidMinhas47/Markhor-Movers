import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:markhor_movers/constants/constants.dart';
import 'package:markhor_movers/models/ride_book.dart';

class RidesHistory {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to add a ride booking to the Firestore collection
  Future<void> addRideBooking(RideBookingModel rideBooking) async {
    final _auth = FirebaseAuth.instance;
    try {
      await _firestore
          .collection(RIDES)
          .doc(_auth.currentUser!.email)
          .collection(YOURRIDES)
          .add(rideBooking.toMap());

      // .doc()
      // .collection(_auth.currentUser!.uid)
      // .add(rideBooking.toMap());
      print('Ride booking added successfully!');
    } catch (e) {
      print('Error adding ride booking: $e');
    }
  }

  // Function to retrieve all ride bookings from the Firestore collection
  Future<List<RideBooking>> getRideBookings() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('rides').get();
      return querySnapshot.docs
          .map((doc) => RideBooking.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting ride bookings: $e');
      return [];
    }
  }
}

// Your RideBooking class (as defined in the previous answer)
class RideBooking {
  final String passengerName;
  final String destination;
  final DateTime pickupTime;
  final double fare;

  RideBooking({
    required this.passengerName,
    required this.destination,
    required this.pickupTime,
    required this.fare,
  });

  factory RideBooking.fromMap(Map<String, dynamic> map) {
    return RideBooking(
      passengerName: map['passengerName'],
      destination: map['destination'],
      pickupTime: DateTime.parse(map['pickupTime']),
      fare: map['fare'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'passengerName': passengerName,
      'destination': destination,
      'pickupTime': pickupTime.toIso8601String(),
      'fare': fare,
    };
  }

  @override
  String toString() {
    return 'RideBooking{passengerName: $passengerName, destination: $destination, pickupTime: $pickupTime, fare: $fare}';
  }
}
