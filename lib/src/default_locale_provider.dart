import 'dart:async';
import 'dart:ui';

import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';
import 'package:localeasy/src/storages/locale_storage.dart';
import 'package:localeasy/src/storages/shared_preferences_storage.dart';
import 'package:localeasy/src/utils.dart';

class LocalEasyDefaultLocaleProvider {
  late final Locale _systemLocale;
  Locale? _storedLocale;
  LocaleStorage _storage;
  final _completer = Completer<void>();

  LocalEasyDefaultLocaleProvider._() : _storage = SharedPreferencesStorage() {
    unawaited(_init());
  }

  static LocalEasyDefaultLocaleProvider? _instance;

  static LocalEasyDefaultLocaleProvider get instance {
    _instance ??= LocalEasyDefaultLocaleProvider._();
    return _instance!;
  }

  Locale get systemLocale {
    if (!_completer.isCompleted) {
      throw StateError('Locale not loaded yet');
    }
    return _systemLocale;
  }

  Locale? get storedLocale {
    if (!_completer.isCompleted) {
      throw StateError('Locale not loaded yet');
    }
    return _storedLocale;
  }

  Future<void> ensureInitialized() {
    return _completer.future;
  }

  Future<void> saveLocale(Locale locale) {
    return _storage.saveLocale(locale);
  }

  Future<Locale?> _loadStoredLocale() async {
    return _storage.loadLocale();
  }

  Future<void> _init() async {
    final (systemLocale, storedLocale) = await (findSystemLocale(), _loadStoredLocale()).wait;
    _systemLocale = systemLocale.toLocale();
    _storedLocale = storedLocale;
    _completer.complete();
  }
}
