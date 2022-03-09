import 'package:flutter/cupertino.dart';

class GoOffline with ChangeNotifier {
  bool _offline = false;
  get userStatus => _offline;

  void toogleStatus(value) {
    _offline = value;
    notifyListeners();
  }
}