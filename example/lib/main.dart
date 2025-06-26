import 'package:flutter/material.dart';
import 'package:localeasy/localeasy.dart';
import 'package:localeasy_example/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalEasy.ensureInitialized();

  runApp(const App());
}
