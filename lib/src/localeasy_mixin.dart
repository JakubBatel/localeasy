import 'package:flutter/widgets.dart';
import 'package:localeasy/src/extensions.dart';
import 'package:localeasy/src/translator.dart';

mixin LocalEasyMixin {
  String get translatorKey;

  Translator getTranslator(BuildContext context) {
    return context.translatorFor(translatorKey);
  }
}
