import 'package:flutter/material.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/generated/l10n.dart';
import 'package:we_exchange/screen/dashboard/admindashboard/agentdashboard.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/withdraw/mno.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/withdraw/banks.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/userdashboard.dart';

class Withdraw extends StatefulWidget {
  static String id = "withdraw";
  const Withdraw({Key? key}) : super(key: key);

  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
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
                S.of(context).withdraw,
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