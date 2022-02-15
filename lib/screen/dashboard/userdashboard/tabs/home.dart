import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/transaction_on_move.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/tabs/withdraw.dart';

import 'deposit.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // late var requestingUser;
  final bool _isuser = false;
  final _currentUserProfile = FirebaseAuth.instance.currentUser?.displayName;
  final Stream<QuerySnapshot> _transaction = FirebaseFirestore.instance
      .collection('transaction')
      .where("is_active", isEqualTo: true)
      .where('is_completed', isEqualTo: false)
      .where("status", isEqualTo: "started")
      .limit(1)
      .snapshots(includeMetadataChanges: true);

  showWithdrawrates(amount) {
    if (amount < 20000) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Charges",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "3000",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Withraw Charges",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "3000",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ],
      );
    }
    if (amount > 20000 && amount < 50000) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Withdraw Charges",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "5000",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Withdraw Charges",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "6000",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    }
  }

  showDepositrates(amount) {
    if (amount < 20000) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Deposit Charges",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "2000",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    }
    if (amount > 20000 && amount < 50000) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Deposit Charges",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "3000",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Deposit Charges",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "4000",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    }
  }

  final CollectionReference ttrips =
      FirebaseFirestore.instance.collection("transaction_trips");

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPrimaryColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: _transaction,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 88, 24, 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Welcome",
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
                              "$_currentUserProfile",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: 1,
                        color: kPrimaryColor,
                        width: MediaQuery.of(context).size.width * .5,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Go Offline",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                          ),
                          Switch(
                            onChanged: (bool value) {},
                            value: false,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Withdraw.id);
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: kContentColorLightTheme,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "Withdraw",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Deposit.id);
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: kSecondaryColor,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "Deposit",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(
                                              color: kContentColorLightTheme),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Center(child: CircularProgressIndicator()),
                      const SizedBox(height: 24),
                      const Text(
                        "Looking for clients please wait ...",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ],
                  ),
                );
              }
              var _transactionData = snapshot.data!.docs.first;
              var _requestingUser = _transactionData["user"];

              if (_requestingUser = _transactionData["user"] !=
                  FirebaseAuth.instance.currentUser!.uid) {
                return DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    maxChildSize: 0.8,
                    minChildSize: 0.25,
                    builder: (BuildContext buildContext,
                        ScrollController controller) {
                      FlutterRingtonePlayer.play(
                        android: AndroidSounds.notification,
                        ios: const IosSound(1023),
                        looping: true,
                        volume: 1.0,
                      );
                      return Container(
                        color: kPrimaryColor,
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          children: [
                            Text(
                              "Transaction information",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Separator(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Service provider"),
                                Text(_transactionData["carrier"]),
                              ],
                            ),
                            const Separator(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Service"),
                                Text(_transactionData["service"]),
                              ],
                            ),
                            const Separator(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Amount to ${_transactionData["service"]}"),
                                Text(_transactionData["amount"]),
                              ],
                            ),
                            const Separator(),
                            _transactionData["service"] == "withdraw"
                                ? showWithdrawrates(
                                    double.parse(_transactionData["amount"]))
                                : showDepositrates(
                                    double.parse(_transactionData["amount"])),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('transaction')
                                    .doc(_transactionData.id)
                                    .update({
                                  'status': "ongoing",
                                  'is_active': false,
                                  'agent':
                                      FirebaseAuth.instance.currentUser!.uid
                                });

                                ttrips.doc(_transactionData.id).set({
                                  'agent':
                                      FirebaseAuth.instance.currentUser!.uid,
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
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0)),
                                  const Icon(
                                    Icons.done,
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
              } else {
                return const CircularProgressIndicator();
              }
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