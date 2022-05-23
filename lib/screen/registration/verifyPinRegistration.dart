import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:wexchange/constants/constants.dart';
import 'package:wexchange/screen/dashboard/userdashboard/userdashboard.dart';
import 'package:wexchange/screen/updateProfile.dart';

class VerifyUserRegistration extends StatefulWidget {
  VerifyUserRegistration({Key? key, required this.name, required this.phone})
      : super(key: key);
  String name;
  String phone;

  @override
  _VerifyUserRegistrationState createState() => _VerifyUserRegistrationState();
}

class _VerifyUserRegistrationState extends State<VerifyUserRegistration> {
  final _auth = FirebaseAuth.instance;
  final _profile = FirebaseFirestore.instance.collection("user_profile");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String? verificationCode;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then((value) {
            if (value.user != null) {
              value.user!.updateDisplayName(widget.name);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateUserProfile()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message.toString()),
              duration: const Duration(seconds: 5),
            ),
          );
        },
        codeSent: (String verificationID, int? respondToken) {
          verificationCode = verificationID;
        },
        timeout: const Duration(seconds: 90),
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationCode = verificationId;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Verify ${widget.name} account",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: kPrimaryColor),
            ),
            Text(
              "Phone ${widget.phone} ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: kPrimaryColor),
            ),
            const Spacer(
              flex: 1,
            ),
            Pinput(
              length: 6,
              controller: _pinPutController,
              focusNode: _pinPutFocusNode,
              onCompleted: (pin) async{
                try {
                  await _auth
                      .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: verificationCode!, smsCode: pin))
                      .then((value) {
                    if (value.user != null) {
                      Navigator.pushNamed(context, UserDashboard.id);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                }
              },
            ),  
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}