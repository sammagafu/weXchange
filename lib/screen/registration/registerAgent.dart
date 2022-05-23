import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wexchange/constants/constants.dart';
import 'package:wexchange/generated/l10n.dart';
import 'package:wexchange/screen/registration/verifyPinRegistration.dart';
import 'package:wexchange/screen/welcomescreen/login.dart';

class RegisterUserAgent extends StatefulWidget {
  // const RegisterUserAgent({Key? key}) : super(key: key);
  static final String id = "registerUserAgent";
  @override
  _RegisterUserAgentState createState() => _RegisterUserAgentState();
}

class _RegisterUserAgentState extends State<RegisterUserAgent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String errorMessage = '';
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
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).welcome,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  S.of(context).caccount,
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: fullnameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter your full name");
                    }
                    if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
                        .hasMatch(value)) {
                      return ("Enter the valid email");
                    }
                    return null;
                  },
                  onSaved: (value) {},
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: kContentDarkTheme,
                    ),
                    labelText: S.of(context).fullname,
                    labelStyle: TextStyle(color: kContentDarkTheme),
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
                    Text(S.of(context).caccount),
                    NeumorphicButton(
                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.all(25),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyUserRegistration(
                                    name: fullnameController.text,
                                    phone:
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
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      side: BorderSide(color: Colors.white)),
                  child: Row(
                    children: [
                      Text(
                        S.of(context).ihaveaccount,
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