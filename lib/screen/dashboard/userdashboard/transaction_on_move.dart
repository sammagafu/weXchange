import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:we_exchange/generated/l10n.dart';
import 'package:we_exchange/screen/dashboard/admindashboard/tabs/message.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/userdashboard.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TransactionOnMove extends StatefulWidget {
  static final String id = "transaction on move";
  final data;

  const TransactionOnMove(this.data, {Key? key}) : super(key: key);

  @override
  _TransactionOnMoveState createState() => _TransactionOnMoveState();
}

class _TransactionOnMoveState extends State<TransactionOnMove> {
  final _transaction = FirebaseFirestore.instance.collection('transaction');
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
      body: StreamBuilder(
          stream: _transaction.doc(widget.data).snapshots(),
          builder: (BuildContext builder, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var user_ = snapshot.data['user'];
              double latitude = snapshot.data['users_location'].latitude;
              double longitude = snapshot.data['users_location'].longitude;
              return Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                        opacity: .9,
                        child: GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(latitude, longitude),
                            zoom: 16.4746,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("user_profile")
                                .doc(user_)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                var _phone = snapshot.data;
                                return GestureDetector(
                                  onTap: () {
                                    launch("tel:${_phone!['phone']}");
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    radius: 25,
                                    child: Icon(
                                      Icons.phone,
                                      color: kContentDarkTheme,
                                    ),
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            }),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Message(widget.data)));
                          },
                          child: const CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            radius: 25,
                            child: Icon(
                              Icons.message,
                              color: kContentDarkTheme,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 50),
                    child: Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              padding:
                                  const EdgeInsets.fromLTRB(24, 16, 24, 16)),
                          onPressed: () {
                            _transaction.doc(widget.data).update({
                              "is_completed": true,
                              "is_active": false,
                              "status": "completed"
                            });
                            Navigator.pushNamed(context, UserDashboard.id);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).finish,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              const Icon(
                                Icons.assignment_turned_in_rounded,
                                color: kContentDarkTheme,
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              );
            } else {
              return const Text("An error happened");
            }
          }),
    );
  }
}