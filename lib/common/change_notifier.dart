import 'package:flutter/foundation.dart';

class ErrorNotifier extends ChangeNotifier {
  bool _hasError = false;
  String _errorMessage;

  void setError(bool hasError, String errorMessage) {
    _hasError = hasError;
    _errorMessage = errorMessage;
    notifyListeners();
  }

  get hasError {
    return _hasError;
  }
  get errorMessage {
    return _errorMessage;
  }
}
