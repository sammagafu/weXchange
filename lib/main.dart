import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:we_exchange/LanguageChangeProvider.dart';
import 'package:we_exchange/UserPreference.dart';
import 'package:we_exchange/screen/dashboard/admindashboard/agentdashboard.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/tabs/deposit.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/tabs/withdraw.dart';
import 'package:we_exchange/screen/dashboard/userdashboard/userdashboard.dart';
import 'package:we_exchange/screen/registration/registerAgent.dart';
import 'package:we_exchange/screen/welcomescreen/landingscreen.dart';
import 'package:we_exchange/screen/welcomescreen/language.dart';
import 'package:we_exchange/screen/welcomescreen/login.dart';
import 'package:we_exchange/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:we_exchange/generated/l10n.dart';

// import 'package:';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoOffline(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: weXchange(),
          locale: Provider.of<LanguageChangeProvider>(context, listen: true)
              .currentLocale,
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('sw', ''), // Spanish, no country code
          ],
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: FirebaseAuth.instance.currentUser == null
              ? const Language()
              : const UserDashboard(),
          routes: {
            LandingScreen.id: (context) => const LandingScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
            RegisterUserAgent.id: (context) => RegisterUserAgent(),
            UserDashboard.id: (context) => const UserDashboard(),
            AgentDashboard.id: (context) => const AgentDashboard(),
            Withdraw.id: (context) => const Withdraw(),
            Deposit.id: (context) => const Deposit(),
          },
        ),
      ),
    );
  }
}