import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/generated/l10n.dart';
import 'package:we_exchange/screen/registration/registerAgent.dart';
import 'package:we_exchange/screen/welcomescreen/login.dart';
import 'package:geolocator/geolocator.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);
  static String id = "Landing screen";

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final String logo = 'assets/images/logo.svg';

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      padding: const EdgeInsets.fromLTRB(20, 135, 20, 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            logo,
            height: 85.0,
            color: kContentDarkTheme,
          ),
          const SizedBox(
            height: 45,
          ),
          Text(
            S.of(context).slogan,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, RegisterUserAgent.id);
            },
            style: TextButton.styleFrom(
              backgroundColor: kSecondaryColor,
              padding: const EdgeInsets.all(20),
            ),
            child: Row(
              children: [
                Text(
                  S.of(context).caccount,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: kContentDarkTheme,
                  size: 16,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(20),
                side: const BorderSide(color: Colors.white)),
            child: Row(
              children: [
                Text(
                  S.of(context).login,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: kContentDarkTheme,
                  size: 16,
                )
              ],
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Text(
            S.of(context).disclaimer,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
          ),
          const Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}