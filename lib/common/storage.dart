import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universal_html/html.dart';

class DreamerStorage {
  static final DreamerStorage _singleton = DreamerStorage._internal();
  final FlutterSecureStorage _secureStorage;
  final Storage _localStorage;

  factory DreamerStorage() {
    return _singleton;
  }

  DreamerStorage._internal()
      : _secureStorage = !kIsWeb ? FlutterSecureStorage() : null,
        _localStorage = kIsWeb ? window.localStorage : null;

  Future<String> read({@required String key}) async {
    if (kIsWeb) {
      return _localStorage[key];
    } else {
      return await _secureStorage.read(key: key);
    }
  }

  void delete({@required String key}) async {
    if (kIsWeb) {
      _localStorage.remove(key);
    } else {
      await _secureStorage.delete(key: key);
    }
  }

  void write({@required String key, @required String value}) async {
    if (kIsWeb) {
      _localStorage[key] = value;
    } else {
      await _secureStorage.write(key: key, value: value);
    }
  }
}
