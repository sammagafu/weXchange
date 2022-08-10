import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:we_exchange/services/locator.service.dart';
import 'package:we_exchange/services/shared_preferences.helper.dart';
import 'package:we_exchange/servicesProvided/noticationService.dart';
import 'package:we_exchange/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:we_exchange/generated/l10n.dart';
import 'package:workmanager/workmanager.dart';

// import 'package:';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  // Workmanager().registerOneOffTask("task-identifier", "simpleTask");
  NotificationService.getPermissions();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    NotificationService().showNotification(
        1, "Got a message whilst in the foreground!", "${message.data}", 2);

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  await setup();
  SharedPreferenceHelper sharedPreferenceHelper =
      getIt.get<SharedPreferenceHelper>();
  sharedPreferenceHelper.setDeclinedTrips(declinedTripIds: []);

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

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case Workmanager.iOSBackgroundTask:
        stderr.writeln("The iOS background fetch was triggered");
        break;
    }
    bool success = true;
    return Future.value(success);
  });
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
