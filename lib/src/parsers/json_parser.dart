import 'dart:convert';
import 'dart:typed_data';

import 'package:localeasy/src/parsers/asset_parser.dart';

class JsonParser implements AssetParser {
  const JsonParser();

  @override
  String get fileExtension => '.json';

  @override
  Map<String, dynamic> parse(Uint8List data) {
    return json.decode(utf8.decode(data));
  }
}
