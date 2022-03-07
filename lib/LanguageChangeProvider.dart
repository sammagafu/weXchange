import 'package:flutter/cupertino.dart';

class LanguageChangeProvider with ChangeNotifier {
  Locale _currentLocale = const Locale("en");
  Locale get currentLocale => _currentLocale;

  void changeLocale(String _locale) {
    _currentLocale = new Locale(_locale);
    notifyListeners();
  }
}