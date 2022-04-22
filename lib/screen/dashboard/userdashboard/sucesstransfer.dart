import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/generated/l10n.dart';
import 'package:we_exchange/screen/dashboard/admindashboard/tabs/message.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/userdashboard.dart';
import 'package:geolocator/geolocator.dart';

class SuccessScreen extends StatefulWidget {
  final data;

  const SuccessScreen(this.data);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  PageController controller = PageController();
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection('transaction');
  double rating = 0;
  Future<void> cancelTransaction() {
    return _transaction
        .doc(widget.data)
        .update({
          'is_active': false,
          'is_completed': false,
          'status': 'cancelled',
        })
        .then((value) => print("Trip Cancelled"))
        .catchError((error) => print("Trip Cancelled: $error"));
  }

  Future<void> confirmLocation(latitude, longitude) {
    return _transaction
        .doc(widget.data)
        .update({"users_location": GeoPoint(latitude, longitude)})
        .then((value) => print("Transaction Updated"))
        .catchError((error) => ("Transaction Cancelled: $error"));
  }

  final CollectionReference ttrips =
      FirebaseFirestore.instance.collection("transaction_trips");
  final chargers = 0;
  showWithdrawrates(amount) {
    if (amount < 20000) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).depositcharges,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                "3000",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).totalpay,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                (amount + 3000).toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      );
    }
    if (amount > 20000 && amount < 50000) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).depositcharges,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                "5000",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).totalpay,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                (amount + 5000).toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      );
    }
    if (amount > 50000) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).depositcharges,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                "6000",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).totalpay,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                (amount + 6000).toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      );
    }
  }

  showDepositrates(amount) {
    if (amount < 20000) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).depositcharges,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                "2000",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).totalpay,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                (amount + 2000).toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      );
    }
    if (amount > 20000 && amount < 50000) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).depositcharges,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                "3000",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).totalpay,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                (amount + 3000).toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      );
    }
    if (amount > 50000) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).depositcharges,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                "4000",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).totalpay,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Text(
                (amount + 4000).toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      );
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: FutureBuilder(
        future: _determinePosition(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            confirmLocation(snapshot.data.latitude, snapshot.data.longitude);
            return StreamBuilder(
                stream: _transaction.doc(widget.data).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.data!["status"] == "completed") {
                    return Container(
                      color: kPrimaryColor,
                      padding: const EdgeInsets.fromLTRB(50, 10, 20, 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          const Icon(
                            Icons.mood,
                            size: 80,
                            color: kContentDarkTheme,
                          ),
                          Text(
                            S.of(context).rate,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          SmoothStarRating(
                              size: 30,
                              rating: rating,
                              halfFilledIconData: Icons.star_half,
                              filledIconData: Icons.star,
                              defaultIconData: Icons.star_border,
                              starCount: 5,
                              borderColor: kWarningColor,
                              color: kWarningColor,
                              allowHalfRating: false,
                              spacing: 2.0,
                              onRatingChanged: (value) {
                                setState(() {
                                  rating = value;
                                });
                              }),
                          const SizedBox(height: 72),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, UserDashboard.id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.of(context).goback),
                                const SizedBox(
                                  width: 24,
                                ),
                                const Icon(Icons.cancel)
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (snapshot.data!["status"] == "ongoing") {
                    var amount = snapshot.data!["amount"];
                    return Container(
                      color: kPrimaryColor,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 45),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          Text(S.of(context).transactionInfo),
                          const SizedBox(height: 12),
                          Container(
                            height: 1,
                            width: 100,
                            color: kContentDarkTheme,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).service,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                snapshot.data!["service"],
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).serviceprovider,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                snapshot.data!["carrier"],
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).depositamount,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                snapshot.data!["amount"],
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          StreamBuilder(
                            stream: ttrips.doc(widget.data).snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(S.of(context).connecting),
                                    const CircularProgressIndicator(),
                                  ],
                                );
                              }
                              var userprofile = snapshot.data['agent'];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Message(widget.data)));
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: kContentDarkTheme,
                                      radius: 25,
                                      child: Icon(
                                        Icons.message,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('user_profile')
                                          .doc(userprofile)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (!snapshot.hasData) {
                                          return const CircularProgressIndicator();
                                        }
                                        var data = snapshot.data;
                                        return GestureDetector(
                                          onTap: () {
                                            launch("tel:${data['phone']}");
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: kContentDarkTheme,
                                            radius: 25,
                                            child: Icon(
                                              Icons.phone,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          Text(S.of(context).charges),
                          const SizedBox(height: 12),
                          Container(
                            height: 1,
                            width: 100,
                            color: kContentDarkTheme,
                          ),
                          const SizedBox(height: 24),
                          snapshot.data!["service"] == "withdraw"
                              ? showWithdrawrates(
                                  double.parse(snapshot.data!["amount"]))
                              : showDepositrates(
                                  double.parse(snapshot.data!["amount"])),
                          const SizedBox(height: 24),
                        ],
                      ),
                    );
                  }
                  return Container(
                    color: kPrimaryColor,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),
                        Text(S.of(context).transactionInfo),
                        const SizedBox(height: 12),
                        Container(
                          height: 1,
                          width: 100,
                          color: kContentDarkTheme,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).service,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            snapshot.data!["service"] == "deposit"
                                ? Text(
                                    S.of(context).deposit,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                : Text(
                                    S.of(context).withdraw,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).serviceprovider,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              snapshot.data!["carrier"],
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).depositamount,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              snapshot.data!["amount"],
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(S.of(context).charges),
                        const SizedBox(height: 12),
                        Container(
                          height: 1,
                          width: 100,
                          color: kContentDarkTheme,
                        ),
                        const SizedBox(height: 24),
                        snapshot.data!["service"] == "withdraw"
                            ? showWithdrawrates(
                                double.parse(snapshot.data!["amount"]))
                            : showDepositrates(
                                double.parse(snapshot.data!["amount"])),
                        const SizedBox(height: 24),
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                              backgroundColor: kSecondaryColor),
                          onPressed: () {
                            cancelTransaction();
                            Navigator.pushNamed(context, UserDashboard.id);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).cancelTransaction,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                              const Icon(
                                Icons.cancel,
                                color: kContentDarkTheme,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else
            return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}