import 'dart:ui';

import 'package:localeasy/src/storages/locale_storage.dart';
import 'package:localeasy/src/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements LocaleStorage {
  static const LOCALE_KEY = 'localeasy_locale';

  final SharedPreferencesAsync _sharedPreferences;

  SharedPreferencesStorage() : _sharedPreferences = SharedPreferencesAsync();

  @override
  Future<Locale?> loadLocale() async {
    final localeString = await _sharedPreferences.getString(LOCALE_KEY);
    return localeString?.toLocale();
  }

  @override
  Future<void> saveLocale(Locale locale) {
    final localeString = locale.toString();
    return _sharedPreferences.setString(LOCALE_KEY, localeString);
  }
}
