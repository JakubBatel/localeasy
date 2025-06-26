import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:localeasy/src/loaders/base_asset_loader.dart';

class RootBundleAssetLoader extends BaseAssetLoader {
  final String path;
  final String? package;

  const RootBundleAssetLoader({required this.path, this.package, super.assetParser});

  @override
  FutureOr<Uint8List> loadAsset(Locale locale) {
    final keyBuilder = StringBuffer();
    if (package != null) {
      keyBuilder.write('packages/$package/');
    }
    keyBuilder.write(path);
    keyBuilder.write('/');
    keyBuilder.write(locale.toLanguageTag());
    keyBuilder.write(assetParser.fileExtension);

    return rootBundle.loadStructuredBinaryData(keyBuilder.toString(), (data) => data.buffer.asUint8List());
  }
}
