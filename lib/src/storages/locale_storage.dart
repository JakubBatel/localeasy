import 'dart:ui';

abstract interface class LocaleStorage {
  Future<Locale?> loadLocale();
  Future<void> saveLocale(Locale locale);
}
