abstract interface class Translator {
  String tr(String key, {List<String> args = const [], Map<String, String> namedArgs = const {}, String gender = ''});
  String plural(String key, num value);
  Translator translatorFor(String prefix);
}
