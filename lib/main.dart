
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wexchange/LanguageChangeProvider.dart';
import 'package:wexchange/UserPreference.dart';
import 'package:wexchange/screen/dashboard/admindashboard/agentdashboard.dart';
import 'package:wexchange/screen/dashboard/userdashboard/tabs/deposit.dart';
import 'package:wexchange/screen/dashboard/userdashboard/tabs/withdraw.dart';
import 'package:wexchange/screen/dashboard/userdashboard/userdashboard.dart';
import 'package:wexchange/screen/registration/registerAgent.dart';
import 'package:wexchange/screen/welcomescreen/landingscreen.dart';
import 'package:wexchange/screen/welcomescreen/language.dart';
import 'package:wexchange/screen/welcomescreen/login.dart';
import 'package:wexchange/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wexchange/generated/l10n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoOffline()),
        ChangeNotifierProvider(create: (_) => LanguageChangeProvider())
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
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
    );
  }
}