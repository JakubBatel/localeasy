abstract interface class Translator {
  String tr(String key);
  Translator translatorFor(String prefix);
}