import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wexchange/constants/constants.dart';
import 'package:wexchange/screen/dashboard/userdashboard/transactions/transactionDetail.dart';

class CancelledTrip extends StatelessWidget {
  final String requestingUser;
  final String tripId;

  const CancelledTrip(
      {Key? key, required this.tripId, required this.requestingUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _declinedTrip = FirebaseFirestore.instance
        .collection("declinedTrips")
        .where("declinedUser",
            isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where("trip", isEqualTo: tripId)
        .limit(1)
        .snapshots();
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: StreamBuilder(
          stream: _declinedTrip,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center();
            }
            if (snapshot.hasData) {
              debugPrint("reached here");
              if (snapshot.data!.docs.isEmpty) {
                return TransactionDetail(tripId: tripId);
              }
              return const TripDetails();
            }
            // debugPrint("reached here");
            return TransactionDetail(tripId: tripId);
          }),
    );
  }
}
