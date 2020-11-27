import 'package:dio/dio.dart';
import 'package:dreamer/common/singleton.dart';
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
      T result = await Singleton().retry.retry(() => f(), retryIf: (e) {
        print("asdasdasdasdasdasd asda $e");
        return e is DioError &&
            e.response != null &&
            e.response.statusCode == 401 &&
            e.response.data['errors']['code'] == 'token_not_valid';
      });
      _isLoading = false;
      notifyListeners();
      return result;
    } on DioError catch (e) {
      if (e.response != null) {
        setError(true, e.response.data["errors"]["detail"]);
        _isLoading = false;
        notifyListeners();
      } else {
        setError(true, "Something went wrong! ${e.message}");
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
