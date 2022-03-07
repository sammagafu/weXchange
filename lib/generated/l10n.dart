// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `welcome to weXchange App, Choose your Language`
  String get welcometext {
    return Intl.message(
      'welcome to weXchange App, Choose your Language',
      name: 'welcometext',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Money Simplified`
  String get slogan {
    return Intl.message(
      'Mobile Money Simplified',
      name: 'slogan',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get caccount {
    return Intl.message(
      'Create Account',
      name: 'caccount',
      desc: '',
      args: [],
    );
  }

  /// `Ingia`
  String get login {
    return Intl.message(
      'Ingia',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Currently this app doesn't handle any transaction`
  String get disclaimer {
    return Intl.message(
      'Currently this app doesn\'t handle any transaction',
      name: 'disclaimer',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Enter your full name`
  String get fullname {
    return Intl.message(
      'Enter your full name',
      name: 'fullname',
      desc: '',
      args: [],
    );
  }

  /// `I have account, Login`
  String get ihaveaccount {
    return Intl.message(
      'I have account, Login',
      name: 'ihaveaccount',
      desc: '',
      args: [],
    );
  }

  /// `Login to your account`
  String get loginbtn {
    return Intl.message(
      'Login to your account',
      name: 'loginbtn',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get deposit {
    return Intl.message(
      'Deposit',
      name: 'deposit',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message(
      'Withdraw',
      name: 'withdraw',
      desc: '',
      args: [],
    );
  }

  /// `Transactions`
  String get activities {
    return Intl.message(
      'Transactions',
      name: 'activities',
      desc: '',
      args: [],
    );
  }

  /// `Transactions`
  String get settings {
    return Intl.message(
      'Transactions',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Go Offline`
  String get goonline {
    return Intl.message(
      'Go Offline',
      name: 'goonline',
      desc: '',
      args: [],
    );
  }

  /// `Looking for requests please wait ...`
  String get lookingforclinets {
    return Intl.message(
      'Looking for requests please wait ...',
      name: 'lookingforclinets',
      desc: '',
      args: [],
    );
  }

  /// `Accept requests transact and get commission`
  String get acceptnearn {
    return Intl.message(
      'Accept requests transact and get commission',
      name: 'acceptnearn',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Network Operators`
  String get mno {
    return Intl.message(
      'Mobile Network Operators',
      name: 'mno',
      desc: '',
      args: [],
    );
  }

  /// `Banks`
  String get bank {
    return Intl.message(
      'Banks',
      name: 'bank',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateprofile {
    return Intl.message(
      'Update Profile',
      name: 'updateprofile',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'sw'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
