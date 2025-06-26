import 'dart:async';
import 'dart:typed_data';

import 'dart:ui';

import 'package:localeasy/src/loaders/asset_loader.dart';
import 'package:localeasy/src/parsers/asset_parser.dart';
import 'package:localeasy/src/parsers/json_parser.dart';

abstract class BaseAssetLoader implements AssetLoader {
  final AssetParser assetParser;

  const BaseAssetLoader({this.assetParser = const JsonParser()});

  FutureOr<Uint8List> loadAsset(Locale locale);

  @override
  FutureOr<Map<String, dynamic>> loadMessages(Locale locale) async {
    final data = await loadAsset(locale);
    return assetParser.parse(data);
  }
}
