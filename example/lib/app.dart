import 'package:flutter/material.dart';
import 'package:localeasy/localeasy.dart';
import 'package:localeasy/utils.dart';
import 'package:localeasy_example/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LocalEasy(
      assetLoaders: const [RootBundleAssetLoader(path: 'assets/i18n')],
      supportedLocales: const [Locale('en'), Locale('sk')],
      fallbackLocale: const Locale('en'),
      child: MaterialApp(
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const HomePage(),
      ),
    );
  }
}
