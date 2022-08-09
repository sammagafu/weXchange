import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String declinedTrips = 'DECLINEDTRIPS';
  static const String uId = 'UID';
  final SharedPreferences prefs;

  SharedPreferenceHelper({required this.prefs});

  Future<void> setDeclinedTrips({required List<String> declinedTripIds}) async {
    await prefs.setStringList(declinedTrips, declinedTripIds);
  }

  List<String>? getDeclinedTrips() {
    final declinedTripsList = prefs.getStringList(declinedTrips);
    return declinedTripsList;
  }
}
