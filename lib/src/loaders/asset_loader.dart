import 'dart:async';
import 'dart:ui';

abstract interface class AssetLoader {
  FutureOr<Map<String, dynamic>> loadMessages(Locale locale);
}
