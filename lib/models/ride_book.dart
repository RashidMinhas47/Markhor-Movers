// Importing the necessary libraries

// Define a data class for booking a ride

import 'package:markhor_movers/models/ride_request_model.dart';

class RideBookingModel {
  final String userID;
  final List<double> origin;
  final List<double> destination;
  final DateTime pickupTime;
  final String status;
  // final double fare;

  // Constructor for the RideBooking class
  RideBookingModel(
      {required this.userID,
      required this.destination,
      required this.origin,
      required this.pickupTime,
      required this.status

      // required this.fare,
      });

  // Factory constructor for creating a RideBooking instance from a map
  factory RideBookingModel.fromMap(Map<String, dynamic> map) {
    return RideBookingModel(
        origin: map[ORIGIN],
        userID: map[USERID],
        destination: map[DESTINATION],
        pickupTime: DateTime.parse(map[TIMESTAMP]),
        status: map[STATUS]
        // fare: map['fare'].toDouble(),
        );
  }

  // Convert the RideBooking instance to a map
  Map<String, dynamic> toMap() {
    return {
      USERID: userID,
      ORIGIN: origin,
      DESTINATION: destination,
      TIMESTAMP: pickupTime.toIso8601String(),
      STATUS: status
      // 'fare': fare,
    };
  }

  // Override the toString() method for easy debugging
  @override
  String toString() {
    return 'RideBooking{USERID: $userID,origin:$origin destination: $destination, pickupTime: $pickupTime,}';
  }
}
