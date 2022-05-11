import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/generated/l10n.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/sucesstransfer.dart';
import 'package:we_exchange/services/location.dart';

enum TransactionStatus { Cancelled, Ongoing, Finished }

class WithdrawBank extends StatefulWidget {
  final banks;
  const WithdrawBank(this.banks);

  @override
  _WithdrawBankState createState() => _WithdrawBankState();
}

class _WithdrawBankState extends State<WithdrawBank> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance.currentUser;
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection('transaction');

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final banks = ModalRoute.of(context)!.settings.arguments as Banks;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(S.of(context).withdraw),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 45, 15, 80),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.money,
                    color: kContentDarkTheme,
                  ),
                  labelText: S.of(context).enteramount,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Amount");
                  }
                  if (double.parse(value) > 100000) {
                    return (S.of(context).limitamount);
                  }
                },
              ),
              const SizedBox(height: 24),
              Text(S.of(context).limitamount),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).withdraw),
                  NeumorphicButton(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(25),
                    onPressed: withdraw,
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> withdraw() async {
    final formState = _formKey.currentState;

    if (formState!.validate()) {
      return _transaction
          .add({
            "amount": amountController.text,
            "carrier": widget.banks.name,
            "is_active": true,
            "is_completed": false,
            "request_time": DateTime.now(),
            "service": "withdraw",
            "user": _auth!.uid,
            "status": "started",
            "users_location": GeoPoint(-6.7640978, 39.2484818)
          })
          .then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => SuccessScreen(value.id))))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }
}