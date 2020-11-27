import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RequestNotifier extends ChangeNotifier {
  bool _hasError = false;
  String _errorMessage;
  bool _isLoading = false;

  Future<T> makeRequest<T>(Function f) async {
    try {
      setError(false, null);
      _isLoading = true;
      notifyListeners();
      T result = await f();
      _isLoading = false;
      notifyListeners();
      return result;
    } on DioError catch (e) {
      if (e.response != null) {
        setError(true, e.response.data["errors"]["detail"]);
        _isLoading = false;
        notifyListeners();
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        setError(true, "Something went wrong! ${e.message}");
        print(e.request);
        // print(e.message);
      }
      return null;
    }
  }

  void setError(bool hasError, String errorMessage) {
    _hasError = hasError;
    _errorMessage = errorMessage;
  }

  get hasError {
    return _hasError;
  }

  get errorMessage {
    return _errorMessage;
  }

  bool get isLoading {
    return _isLoading;
  }
}
