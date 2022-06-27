import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/generated/l10n.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/transaction_on_move.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/tabs/withdraw.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:we_exchange/services/location.dart';
import 'package:we_exchange/servicesProvided/noticationService.dart';

import 'deposit.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      NotificationService().flutterLocalNotificationsPlugin;

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

  final _auth = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _transaction = FirebaseFirestore.instance
      .collection('transaction')
      .where("is_active", isEqualTo: true)
      .where('is_completed', isEqualTo: false)
      .where("status", isEqualTo: "started")
      .limit(1)
      //includeMetadataChanges: true
      .snapshots();
  final CollectionReference ttrips =
      FirebaseFirestore.instance.collection("transaction_trips");
  // late var requestingUser;
  final _storage = const FlutterSecureStorage();
  final _location = Location();

  showWithdrawrates(amount) {
    if (amount <= 20000) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).withdrawcharges,
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
    if (amount > 20001 && amount < 50000) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).withdrawcharges,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
          Text(
            (amount + 5000).toString(),
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).withdrawcharges,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
          Text(
            (amount + 6000).toString(),
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
        ],
      );
    }
  }

  showDepositrates(amount) {
    if (amount <= 20000) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).depositcharges,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
          Text(
            (amount + 2000).toString(),
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
        ],
      );
    }
    if (amount > 20000 && amount <= 50000) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).depositcharges,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
          Text(
            (amount + 3000).toString(),
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).depositcharges,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
          Text(
            (amount + 4000).toString() + " TZS",
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
        ],
      );
    }
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      Navigator.pushNamed(
        context,
        Deposit.id,
      );
    }
  }

//declined trip variable
  String? _declinedTrip;
  Future<String?> _getDeclinedTrips() async {
    return _declinedTrip = await _storage.read(key: "declinedTrip");
  }

  Future<void> _addDeclinedTrips(trip) async {
    return await _storage.write(key: "declinedTrip", value: trip);
  }

  @override
  void initState() {
    _getDeclinedTrips();
    super.initState();
    // _requestPermissions();
    tz.initializeTimeZones();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: StreamBuilder(
          stream: _transaction,
          builder: (BuildContext build, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const TripDetails();
              }
              var _transactionData = snapshot.data!.docs.first;
              var _requestingUser = _transactionData["user"];

              double latitude = _transactionData['users_location'].latitude;
              double longitude = _transactionData['users_location'].longitude;

              if (_declinedTrip == _transactionData.id &&
                  _requestingUser == _auth?.uid) {
                return const TripDetails();
              } else {
                FlutterRingtonePlayer.play(
                  android: AndroidSounds.notification,
                  ios: const IosSound(1023),
                  looping: true,
                  volume: 1.0,
                );
                NotificationService().showNotification(1, "You have a request",
                    "Some requested for your service", 2);
                return Container(
                  color: kPrimaryColor,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).transactionInfo,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Separator(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).serviceprovider),
                          Text(_transactionData["carrier"]),
                        ],
                      ),
                      const Separator(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).service),
                          _transactionData["service"] == "deposit"
                              ? Text(S.of(context).deposit)
                              : Text(S.of(context).withdraw)
                        ],
                      ),
                      const Separator(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).depositamount),
                          Text(_transactionData["amount"]),
                        ],
                      ),
                      const Separator(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).distancebtn,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14)),
                          FutureBuilder(
                              future: _determinePosition(),
                              builder: (BuildContext builder,
                                  AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                } else {
                                  double distanceInMeters =
                                      (Geolocator.distanceBetween(
                                              latitude,
                                              longitude,
                                              snapshot.data.latitude,
                                              snapshot.data.longitude) /
                                          1000);
                                  return Text(
                                      "${distanceInMeters.toInt().toString()} KM");
                                }
                              }),
                        ],
                      ),
                      const Separator(),
                      _transactionData["service"] == "withdraw"
                          ? showWithdrawrates(
                              double.parse(_transactionData["amount"]))
                          : showDepositrates(
                              double.parse(_transactionData["amount"])),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('transaction')
                              .doc(_transactionData.id)
                              .update({
                            'status': "ongoing",
                            'is_active': false,
                            'agent': FirebaseAuth.instance.currentUser!.uid
                          });

                          ttrips.doc(_transactionData.id).set({
                            'agent': FirebaseAuth.instance.currentUser!.uid,
                            'transaction': _transactionData.id,
                            "accepted_time": Timestamp.now(),
                          });
                          FlutterRingtonePlayer.stop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TransactionOnMove(_transactionData.id),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            backgroundColor: kSecondaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Accept ",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                            const Icon(
                              Icons.done,
                              color: kContentDarkTheme,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                          _addDeclinedTrips(_transactionData.id.toString());
                        },
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            backgroundColor: kErrorColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).decline,
                              style: Theme.of(context).textTheme.headline5,
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
                      )
                    ],
                  ),
                );
              }
              return Container();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class Separator extends StatelessWidget {
  const Separator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Container(
          height: .5,
          color: kContentDarkTheme,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class TripDetails extends StatefulWidget {
  const TripDetails({Key? key}) : super(key: key);

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  final _auth = FirebaseAuth.instance.currentUser;

  final CollectionReference ttrips =
      FirebaseFirestore.instance.collection("transaction_trips");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kContentDarkTheme,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 88, 24, 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                S.of(context).welcome,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    _auth?.displayName ?? "User's name",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Deposit.id);
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: kSecondaryColor,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        S.of(context).deposit,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Withdraw.id);
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: kContentColorLightTheme,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        S.of(context).withdraw,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 62),
            Text(
              S.of(context).lookingforclinets,
              style: const TextStyle(color: kPrimaryColor),
            ),
            Text(
              S.of(context).acceptnearn,
              style: const TextStyle(color: kPrimaryColor),
            )
          ],
        ),
      ),
    );
  }
}
