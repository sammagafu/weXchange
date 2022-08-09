import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TransactionModel {
  //  "amount": amountController.text,
  //       "carrier": widget.mno.name,
  //       "is_active": true,
  //       "is_completed": false,
  //       "request_time": DateTime.now().toIso8601String(),
  //       "service": "deposit",
  //       "user": _auth!.uid,
  //       "status": "started",
  //       "users_location": const GeoPoint(-6.7640978, 39.2484818)
  String amount;
  String carrier;
  bool isActive;
  bool isComplete;
  String requestTime;
  String service;
  String uid;
  String status;
  UserLocation userLocation;

  TransactionModel(
      {required this.amount,
      required this.carrier,
      required this.isActive,
      required this.isComplete,
      required this.requestTime,
      required this.service,
      required this.uid,
      required this.status,
      required this.userLocation});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        amount: json['amount'],
        carrier: json['carrier'],
        isActive: json['is_active'],
        isComplete: json['is_complete'] != null ? true : false,
        requestTime: json['request_time'],
        service: json['service'],
        uid: json['user'],
        status: json['status'],
        userLocation: json['user_location'] != null
            ? UserLocation(userLocation: json['users_location'])
            : UserLocation(userLocation: GeoPoint(-6.7640978, 39.2484818)),
      );

  Map toJson() => {
        "amount": amount,
        "carrier": carrier,
        "is_active": isActive,
        "is_completed": isComplete,
        "request_time": requestTime,
        "service": service,
        "user": uid,
        "status": status,
        "users_location": userLocation.toJson()
      };
}

class UserLocation {
  GeoPoint userLocation;

  UserLocation({required this.userLocation});
  GeoPoint fromJson(Map json) => GeoPoint(json['latitude'], json['longitude']);
  List<double> toJson() => [userLocation.latitude, userLocation.longitude];
}
