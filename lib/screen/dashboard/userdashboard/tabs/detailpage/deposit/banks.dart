import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wexchange/constants/constants.dart';
import 'package:wexchange/generated/l10n.dart';
import 'package:wexchange/screen/dashboard/userdashboard/sucesstransfer.dart';
import 'package:wexchange/services/location.dart';

class DepositDetailBanks extends StatefulWidget {
  final banks;
  const DepositDetailBanks(this.banks);

  @override
  _DepositDetailBankState createState() => _DepositDetailBankState();
}

class _DepositDetailBankState extends State<DepositDetailBanks> {
  final _auth = FirebaseAuth.instance.currentUser;
  final CollectionReference _transaction =
      FirebaseFirestore.instance.collection('transaction');
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        // ${widget.banks.name}".toLowerCase()
        title: Text(S.of(context).deposit),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 45, 15, 30),
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
                  Text(S.of(context).deposit),
                  NeumorphicButton(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(25),
                    onPressed: deposit,
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

  Future<void> deposit() async {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      return _transaction
          .add({
            "amount": amountController.text,
            "carrier": widget.banks.name,
            "is_active": true,
            "is_completed": false,
            "request_time": DateTime.now(),
            "service": "deposit",
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