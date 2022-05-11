import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/generated/l10n.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/deposit/banks.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/deposit/mno.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/userdashboard.dart';

class Deposit extends StatefulWidget {
  static String id = "deposit";

  const Deposit({Key? key}) : super(key: key);

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  final _auth = FirebaseAuth.instance.currentUser;
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection('transaction');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kContentColorLightTheme,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, UserDashboard.id);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        color: kContentDarkTheme,
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                S.of(context).deposit,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: kPrimaryColor),
              ),
            ),
            const Mno(),
            const BanksWidget(),
          ],
        ),
      ),
    );
  }
}