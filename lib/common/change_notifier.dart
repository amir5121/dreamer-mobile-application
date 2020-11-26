import 'package:flutter/foundation.dart';

class ErrorNotifier extends ChangeNotifier {
  bool _hasError = false;
  String _errorMessage;

  set hasError(bool hasError) {
    _hasError = hasError;
  }

  set errorMessage(String errorMessage) {
    _errorMessage = errorMessage;
  }
}
