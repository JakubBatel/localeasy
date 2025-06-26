import 'package:flutter/widgets.dart';
import 'package:localeasy/src/localeasy.dart';
import 'package:localeasy/src/translator.dart';

extension LocalEasyContext on BuildContext {
  Locale get locale => LocalEasy.of(this).locale;
  List<Locale> get supportedLocales => LocalEasy.of(this).supportedLocales;

  void setLocale(Locale locale) => LocalEasy.of(this).locale = locale;

  String tr(String key) => LocalEasy.of(this).tr(key);

  Translator translatorFor(String prefix) => LocalEasy.of(this).translatorFor(prefix);
}

extension LocalEasyString on String {
  String tr(BuildContext context) => LocalEasy.of(context).tr(this);
}
