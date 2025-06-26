import 'package:localeasy/src/translator.dart';

class SubKeyTranslator implements Translator {
  final Translator _translator;
  final String _prefix;

  SubKeyTranslator(this._translator, this._prefix);

  @override
  String tr(String key) {
    return _translator.tr('$_prefix.$key');
  }

  @override
  Translator translatorFor(String prefix) {
    return SubKeyTranslator(this, prefix);
  }
}
