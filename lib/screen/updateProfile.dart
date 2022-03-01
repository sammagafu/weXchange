import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_exchange/constants/constants.dart';

class UpdateUserProfile extends StatefulWidget {
  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
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
        child: Container(
          padding:
              const EdgeInsets.only(top: 100, left: 18, right: 18, bottom: 100),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Update User details",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 32),
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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: kContentDarkTheme,
                    ),
                    labelText: "Enter your full name",
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
                const SizedBox(height: 12),
                Text(
                  errorMessage,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: kErrorColor),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}