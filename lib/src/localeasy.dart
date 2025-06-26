import 'package:flutter/material.dart';
import 'package:localeasy/src/controller.dart';
import 'package:localeasy/src/default_locale_provider.dart';
import 'package:localeasy/src/loaders/asset_loader.dart';

class LocalEasy extends StatefulWidget {
  final List<AssetLoader> assetLoaders;
  final bool saveLocale;
  final List<Locale> supportedLocales;
  final Locale fallbackLocale;
  final ValueChanged<Locale>? onLocaleChanged;
  final Widget child;

  const LocalEasy({
    super.key,
    required this.assetLoaders,
    required this.supportedLocales,
    required this.fallbackLocale,
    this.saveLocale = true,
    this.onLocaleChanged,
    required this.child,
  });

  static LocalEasyController of(BuildContext context) => _LocalEasyProvider.of(context).controller;

  static Future<void> ensureInitialized() => LocalEasyDefaultLocaleProvider.instance.ensureInitialized();

  @override
  State<LocalEasy> createState() => _LocalEasyState();
}

class _LocalEasyState extends State<LocalEasy> {
  late final LocalEasyController _controller;
  late Locale _locale;
  bool _initialLoadingIsDone = false;

  @override
  void initState() {
    super.initState();
    _controller = LocalEasyController(
      assetLoaders: widget.assetLoaders,
      saveLocale: widget.saveLocale,
      supportedLocales: widget.supportedLocales,
      fallbackLocale: widget.fallbackLocale,
    );
    _locale = _controller.locale;
    _initialLoadingIsDone = !_controller.isLoading;
    _controller.addListener(_onLocaleChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onLocaleChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LocalEasyProvider(
      controller: _controller,
      locale: _locale,
      initialLoadingIsDone: _initialLoadingIsDone,
      child: widget.child,
    );
  }

  void _onLocaleChanged() {
    if (!_controller.isLoading) {
      setState(() {
        _locale = _controller.locale;
        _initialLoadingIsDone = true;
      });
      widget.onLocaleChanged?.call(_controller.locale);
    }
  }
}

class _LocalEasyProvider extends InheritedWidget {
  final LocalEasyController controller;
  final Locale locale;
  final bool initialLoadingIsDone;

  const _LocalEasyProvider({
    required this.controller,
    required this.locale,
    required this.initialLoadingIsDone,
    required super.child,
  });

  static _LocalEasyProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_LocalEasyProvider>()!;

  @override
  bool updateShouldNotify(covariant _LocalEasyProvider oldWidget) {
    return locale != oldWidget.locale ||
        controller != oldWidget.controller ||
        initialLoadingIsDone != oldWidget.initialLoadingIsDone;
  }
}
