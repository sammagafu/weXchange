import 'package:flutter/material.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/generated/l10n.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/tabs/detailpage/deposit/mno.dart';
import 'package:we_exchange/servicesProvided/mno.dart';

class Mno extends StatefulWidget {
  const Mno({Key? key}) : super(key: key);

  @override
  _MnoState createState() => _MnoState();
}

class _MnoState extends State<Mno> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            S.of(context).mno,
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
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            height: 180,
            child: ListView.builder(
              // padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: mno.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MnoDepositDetail(mno[index]),
                      ));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: kContentDarkTheme,
                        radius: 40,
                        backgroundImage: AssetImage(mno[index].url),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(
                        mno[index].name,
                        style: Theme.of(context).textTheme.headline6,
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