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
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
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
                const SizedBox(height: 100),
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
                      onPressed: () {
                        final formState = _formKey.currentState;
                        if (formState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyPin(
                                        phoneNumber:
                                            "+255${phoneNumberController.text.toString()}",
                                      )));
                        }
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
}