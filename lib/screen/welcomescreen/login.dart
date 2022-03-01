import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/screen/registration/registerAgent.dart';
import 'package:we_exchange/screen/registration/verifyPin.dart';

class LoginScreen extends StatefulWidget {
  static String id = "Login Account";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorMessage = '';
  final _form = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, left: 18, right: 18, bottom: 100),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  "Login to your Account",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter phone number");
                    }
                    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                        .hasMatch("+255${value}")) {
                      return ("Enter the valid phone number");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.phone_iphone),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "+255",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    labelStyle: const TextStyle(color: kContentDarkTheme),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kContentDarkTheme,
                        width: 1,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kContentDarkTheme,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Create account"),
                    NeumorphicButton(
                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.all(25),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyPin(
                                    phoneNumber:
                                        "+255${phoneNumberController.text}")));
                      },
                      style: const NeumorphicStyle(
                        lightSource: LightSource.topLeft,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: kPrimaryColor,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: kContentDarkTheme,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterUserAgent.id);
                  },
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      side: BorderSide(color: Colors.white)),
                  child: Row(
                    children: [
                      Text(
                        "Create account",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}