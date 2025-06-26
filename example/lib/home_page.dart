import 'package:flutter/material.dart';
import 'package:localeasy/localeasy.dart';
import 'package:localeasy_example/language_settings_page.dart';

class HomePage extends StatelessWidget with LocalEasyMixin {
  const HomePage({super.key});

  @override
  String get translatorKey => 'home_page';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translator = getTranslator(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 24,
              children: [
                Text('You can translate your texts using following methods:', style: theme.textTheme.headlineSmall),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 12,
                  children: [
                    Text('Use "my_key".tr(context)', style: theme.textTheme.titleMedium, textAlign: TextAlign.center),
                    Text(context.tr("home_page.example_text"), textAlign: TextAlign.center),
                    Text('Use context.tr("my_key")', style: theme.textTheme.titleMedium, textAlign: TextAlign.center),
                    Text("home_page.example_text".tr(context), textAlign: TextAlign.center),
                    Text(
                      'Use context.translatorFor("my_prefix").tr("my_key")',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Text(translator.tr("example_text"), textAlign: TextAlign.center),
                  ],
                ),
                Text('You can use following methods to get locale information:', style: theme.textTheme.headlineSmall),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 12,
                  children: [
                    Text(
                      'Use context.locale to get current locale',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Text(context.locale.toString(), textAlign: TextAlign.center),
                    Text(
                      'Use context.supportedLocales to get supported locales',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Text(context.supportedLocales.join(', '), textAlign: TextAlign.center),
                    Text(
                      'You can also add listener to get locale changes',
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Text('LocalEasy(\n    onLocaleChanged: onLocaleChanged,\n    child: MaterialApp(...),\n);'),
                    Text('or', style: theme.textTheme.titleMedium, textAlign: TextAlign.center),
                    Text('use LocalEasy.of(context).addListener(listener)', textAlign: TextAlign.center),
                  ],
                ),
                Center(
                  child: FilledButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => const LanguageSettingsPage())),
                    child: Text(translator.tr('language_settings_button.label')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
