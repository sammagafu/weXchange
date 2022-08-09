import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_exchange/services/shared_preferences.helper.dart';

final getIt = GetIt.instance;
//
Future<void> setup() async {
  final _prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferenceHelper>(
    SharedPreferenceHelper(prefs: _prefs),
  );
}
