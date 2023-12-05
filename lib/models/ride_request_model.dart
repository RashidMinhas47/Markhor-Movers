import 'package:cloud_firestore/cloud_firestore.dart';

class RideRequestModel {
  final String userId;
  final List<double> origin;
  final List<double> destination;
  final DateTime timestamp;
  String status;

  // Constructor for the RideRequest class
  RideRequestModel({
    required this.userId,
    required this.origin,
    required this.destination,
    required this.timestamp,
    required this.status,
  });

  // Factory constructor to create a RideRequest instance from a map
  factory RideRequestModel.fromMap(Map<String, dynamic> map) {
    return RideRequestModel(
      userId: map[USERID],
      origin: map[ORIGIN],
      destination: map[DESTINATION],
      timestamp: (map[TIMESTAMP] as Timestamp).toDate(),
      status: map[STATUS],
    );
  }

  // Method to convert the RideRequest instance to a map
  Map<String, dynamic> toMap() {
    return {
      USERID: userId,
      ORIGIN: origin,
      DESTINATION: destination,
      TIMESTAMP: timestamp,
      STATUS: status,
    };
  }
}

const USERID = 'USERID';

const ORIGIN = 'ORIGIN';

const DESTINATION = 'DESTINATION';

const STATUS = 'STATUS';
const TIMESTAMP = 'TIMESTAMP';
