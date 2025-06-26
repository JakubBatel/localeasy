import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:localeasy/src/default_locale_provider.dart';
import 'package:localeasy/src/loaders/asset_loader.dart';
import 'package:localeasy/src/sub_key_translator.dart';
import 'package:localeasy/src/translator.dart';

class LocalEasyController extends ChangeNotifier implements Translator {
  final List<AssetLoader> assetLoaders;
  final bool saveLocale;
  final List<Locale> supportedLocales;
  final Locale fallbackLocale;

  LocalEasyController({
    required this.assetLoaders,
    this.saveLocale = true,
    required this.supportedLocales,
    required this.fallbackLocale,
  }) {
    final Locale wantedLocale;
    if (saveLocale) {
      wantedLocale =
          LocalEasyDefaultLocaleProvider.instance.storedLocale ?? LocalEasyDefaultLocaleProvider.instance.systemLocale;
    } else {
      wantedLocale = LocalEasyDefaultLocaleProvider.instance.systemLocale;
    }
    locale = wantedLocale;
  }

  late Locale _locale;
  bool _isLoading = false;
  Map<String, dynamic> _messages = {};

  bool get isLoading => _isLoading;
  Locale get locale => _locale;

  set locale(Locale value) {
    final Locale locale;
    if (supportedLocales.contains(value)) {
      locale = value;
    } else {
      locale = fallbackLocale;
    }

    _locale = locale;
    if (saveLocale) {
      unawaited(LocalEasyDefaultLocaleProvider.instance.saveLocale(value));
    }
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    _isLoading = true;
    notifyListeners();

    final assets = await Future.wait(assetLoaders.map((loader) async => await loader.loadMessages(_locale)));
    final messages = <String, dynamic>{};
    for (final asset in assets) {
      // TODO detect duplicates
      messages.addAll(asset);
    }
    _messages = messages;

    _isLoading = false;
    notifyListeners();
  }

  @override
  String tr(String key) {
    dynamic value = _messages;
    for (final chunk in key.split('.')) {
      switch (value) {
        case Map():
          value = value[chunk];
        default:
          // TODO log error
          return key;
      }
    }
    if (value is! String) {
      // TODO log error
      return key;
    }
    return value;
  }

  @override
  Translator translatorFor(String prefix) {
    return SubKeyTranslator(this, prefix);
  }
}
