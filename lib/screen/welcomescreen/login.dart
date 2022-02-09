import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/screen/dashboard/admindashboard/agentdashboard.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/userdashboard.dart';
import 'package:we_exchange/screen/registration/registerAgent.dart';

class LoginScreen extends StatefulWidget {
  static String id = "Login Account";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection("user_profile");
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 135, 20, 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 50),
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  color: kContentDarkTheme,
                  height: 85.0,
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter phone number");
                    }
                    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                        .hasMatch(value)) {
                      return ("Enter the valid phone number");
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone_iphone,
                      color: kContentDarkTheme,
                    ),
                    labelText: "Enter your phone number",
                    labelStyle: TextStyle(color: kContentDarkTheme),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kContentDarkTheme,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kContentDarkTheme,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: passwordController,
                  autofocus: false,
                  obscureText: _isObscure,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter your Password");
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: kContentDarkTheme,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                      // child: Icon(Icons.remove_red_eye,color: kContentDarkTheme,)
                    labelText: "Enter your password",
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
                const SizedBox(height: 12),
                Text(
                  errorMessage,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: kErrorColor),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    NeumorphicButton(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.all(25),
                      onPressed: signIn,
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Forgot your password ?"),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Reset Password",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: kContentColorLightTheme),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Dont have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterUserAgent.id);
                      },
                      child: Text(
                        "create account",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: kContentColorLightTheme),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: phoneNumberController.text, password: passwordController.text);
        var userData = FirebaseAuth.instance.currentUser;

        var userStatus =
            await _firestore.where("uiid", isEqualTo: userData?.uid).get();
        var is_agent = userStatus.docs.first.get("is_agent");
        print(userStatus.docs.first.data());
        if (is_agent == true) {
          Navigator.pushNamed(context, AgentDashboard.id);
        } else {
          Navigator.pushNamed(context, UserDashboard.id);
        }
      } on FirebaseAuthException catch (err) {
        if (err.code == 'user-not-found') {
          setState(() {
            errorMessage = "Wrong Email Entered please check";
          });
        } else if (err.code == 'wrong-password') {
          setState(() {
            errorMessage = "Wrong Password please try again";
          });
        }
      }
    }
  }
}