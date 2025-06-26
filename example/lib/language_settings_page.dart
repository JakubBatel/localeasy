import 'package:flutter/material.dart';
import 'package:localeasy/localeasy.dart';

class LanguageSettingsPage extends StatelessWidget with LocalEasyMixin {
  const LanguageSettingsPage({super.key});

  @override
  String get translatorKey => 'language_settings_page';

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final supportedLocales = context.supportedLocales;

    final translator = getTranslator(context);

    return Scaffold(
      appBar: AppBar(title: Text(translator.tr('title'))),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final locale = supportedLocales[index];

          return ListTile(
            selected: locale == currentLocale,
            onTap: () => context.setLocale(locale),
            title: Text('common.locale.$locale'.tr(context)),
          );
        },
        itemCount: supportedLocales.length,
      ),
    );
  }
}
