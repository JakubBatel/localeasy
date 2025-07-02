import 'package:localeasy/src/translator.dart';

class SubKeyTranslator implements Translator {
  final Translator _translator;
  final String _prefix;

  SubKeyTranslator(this._translator, this._prefix);

  @override
  String tr(String key, {List<String> args = const [], Map<String, String> namedArgs = const {}, String gender = ''}) {
    return _translator.tr('$_prefix.$key', args: args, namedArgs: namedArgs, gender: gender);
  }

  @override
  String plural(String key, num value) {
    return _translator.plural('$_prefix.$key', value);
  }

  @override
  Translator translatorFor(String prefix) {
    return SubKeyTranslator(this, prefix);
  }
}
