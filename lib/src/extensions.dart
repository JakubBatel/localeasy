import 'package:flutter/widgets.dart';
import 'package:localeasy/src/localeasy.dart';
import 'package:localeasy/src/translator.dart';

extension LocalEasyContext on BuildContext {
  Locale get locale => LocalEasy.of(this).locale;
  List<Locale> get supportedLocales => LocalEasy.of(this).supportedLocales;

  void setLocale(Locale locale) => LocalEasy.of(this).locale = locale;

  String tr(String key, {List<String> args = const [], Map<String, String> namedArgs = const {}, String gender = ''}) =>
      LocalEasy.of(this).tr(key, args: args, namedArgs: namedArgs, gender: gender);

  String plural(String key, num value) => LocalEasy.of(this).plural(key, value);

  Translator translatorFor(String prefix) => LocalEasy.of(this).translatorFor(prefix);
}

extension LocalEasyString on String {
  String tr(BuildContext context) => LocalEasy.of(context).tr(this);
  String plural(BuildContext context, num value) => LocalEasy.of(context).plural(this, value);
}
