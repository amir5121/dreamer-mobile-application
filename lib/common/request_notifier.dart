import 'package:dio/dio.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:flutter/foundation.dart';

class RequestNotifier extends ChangeNotifier {
  bool _hasError = false;
  String _errorMessage;
  int _errorStatus;
  String _errorCode;
  bool _isLoading = false;

  Future<T> makeRequest<T>(Function f) async {
    try {
      unSetError();
      _isLoading = true;
      notifyListeners();
      T result = await Singleton().retry.retry(() => f(), retryIf: (e) {
        print("MakeRequest Retry! $e");
        return e is DioError &&
            e.response != null &&
            e.response.statusCode == 401 &&
            e.response.data['message_code'] == 'token_not_valid';
      });
      _isLoading = false;
      notifyListeners();
      print("makeRequest result $result");
      return result;
    } on DioError catch (e) {
      print("failed completely asda $e");
      setResponseError(e);
      notifyListeners();
    } catch (e) {
      setError(
        errorMessage: "Something wen't wrong",
        errorCode: null,
        errorStatus: null,
      );
    }
  }

  void setResponseError(DioError err) {
    if (err.response.statusCode == 500) {
      setError(
        errorMessage: "Server Failure! Try again Later!",
        errorCode: null,
        errorStatus: err.response.statusCode,
      );
    } else {
      setError(
        errorMessage: err.response.data['message'],
        errorCode: err.response.data['message_code'],
        errorStatus: err.response.statusCode,
      );
    }
  }

  void setError({
    @required String errorMessage,
    @required String errorCode,
    @required int errorStatus,
  }) {
    _isLoading = false;
    _hasError = true;
    _errorMessage = errorMessage;
    _errorCode = errorCode;
    _errorStatus = errorStatus;
  }

  void unSetError() {
    _hasError = false;
    _errorMessage = null;
    _errorStatus = null;
    _errorCode = null;
  }

  bool get hasError {
    return _hasError;
  }

  int get errorStatus {
    return _errorStatus;
  }

  String get errorMessage {
    return _errorMessage;
  }

  String get errorCode {
    return _errorCode;
  }

  bool get isLoading {
    return _isLoading;
  }
}
