import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:markhor_movers/constants/constants.dart';
import 'package:markhor_movers/models/ride_request_model.dart';

class RideRequestService {
  final _userName = FirebaseAuth.instance.currentUser!.email;

  // Function to make a ride request
  Future<void> makeRideRequest(
      String userId, List<double> origin, List<double> destination) async {
    final rideRequestsCollection = FirebaseFirestore.instance
        .collection(RIDEREQUEST)
        .doc(_userName)
        .collection(YOURRIDES);

    await rideRequestsCollection.add({
      USERID: userId,
      ORIGIN: origin,
      DESTINATION: destination,
      TIMESTAMP: FieldValue.serverTimestamp(),
      STATUS: 'pending',
      // Add more details if needed
    });
  }

  // Function to update the status of a ride request
  Future<void> updateRideRequestStatus(
      String requestId, String newStatus) async {
    final rideRequestsCollection = FirebaseFirestore.instance
        .collection(RIDEREQUEST)
        .doc(_userName)
        .collection(RIDEREQUEST);
    await rideRequestsCollection.doc(requestId).update({
      STATUS: newStatus,
      // Add more fields to update if needed
    });
  }

  // Stream to listen to changes in the ride requests collection
  Stream<QuerySnapshot> getRideRequestsStream() {
    final rideRequestsCollection = FirebaseFirestore.instance
        .collection(RIDEREQUEST)
        .doc(_userName)
        .collection(RIDEREQUEST);
    return rideRequestsCollection.snapshots();
  }
}
