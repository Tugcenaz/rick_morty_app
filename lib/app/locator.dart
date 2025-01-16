import 'package:get_it/get_it.dart';
import 'package:rick_morty_app/app/services/api_service.dart';
import 'package:rick_morty_app/app/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  locator.registerLazySingleton<PreferencesService>(
      () => PreferencesService(prefs: prefs));

  locator.registerLazySingleton<ApiService>(() => ApiService());
}
