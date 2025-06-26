import 'dart:typed_data';

abstract interface class AssetParser {
  String get fileExtension;

  Map<String, dynamic> parse(Uint8List data);
}
