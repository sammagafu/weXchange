import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:we_exchange/constants/constants.dart';
import 'package:we_exchange/screen/welcomescreen/landingscreen.dart';
    
class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String default_language = 'English';
  var language = [
    'English',
    'Swahili',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:SafeArea(
      // color: kContentDarkTheme,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                height: 100.0,
              ),
            ),
            Expanded(child: Text('Welcome to weXchage App, \n  your language', style: Theme.of(context).textTheme.headline5!.copyWith(color: kPrimaryColor),textAlign: TextAlign.center,)),
            Padding(

              padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
              child: DropdownButton(
                dropdownColor: kSecondaryColor,
                onChanged: (value){
                  Navigator.pushNamed(context, LandingScreen.id);
                },
                isExpanded: true,
                hint: Text("Choose your language",style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kSecondaryColor),),
                iconSize: 30.0,
                elevation: 4,
                icon: const Icon(Icons.language,color: kSecondaryColor,),
                // value: default_language,
                items: language
                    .map((String val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val, style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: kPrimaryColor)
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 180,),
          ],
      ),
    ),
    );
  }
}