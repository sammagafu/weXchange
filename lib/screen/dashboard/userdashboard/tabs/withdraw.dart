import 'package:flutter/material.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/deposit/mno.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/deposit/banks.dart';

class Withdraw extends StatefulWidget {
  static String id = "withdraw";
  const Withdraw({Key? key}) : super(key: key);

  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kContentDarkTheme,
      padding: const EdgeInsets.fromLTRB(15, 65, 15, 30),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Withdraw",
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
    );
  }
}