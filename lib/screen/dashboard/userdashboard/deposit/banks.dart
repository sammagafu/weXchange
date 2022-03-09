import 'package:flutter/material.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/generated/l10n.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/tabs/detailpage/deposit/banks.dart';
import 'package:we_exchange/servicesProvided/banks.dart';

class BanksWidget extends StatefulWidget {
  const BanksWidget({Key? key}) : super(key: key);

  @override
  _BanksWidgetState createState() => _BanksWidgetState();
}

class _BanksWidgetState extends State<BanksWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            S.of(context).bank,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: kPrimaryColor),
          ),
        ),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: kContentColorLightTheme,
          elevation: 7,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            height: 170,
            child: ListView.builder(
              // padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: banks.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DepositDetailBanks(banks[index]),
                      ));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: CircleAvatar(
                        backgroundColor: kContentDarkTheme,
                        radius: 40,
                        backgroundImage: AssetImage(banks[index].url),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(
                        banks[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: kContentDarkTheme),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}