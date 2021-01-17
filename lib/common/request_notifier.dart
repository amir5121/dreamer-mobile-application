import 'package:dio/dio.dart';
import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/extensions/string_extension.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:flutter/foundation.dart';

class RequestNotifier extends ChangeNotifier {
  bool _hasError = false;
  String _errorMessage;
  int _errorStatus;
  String _errorCode;
  bool _isLoading = false;
  bool _madeSuccessfulRequest = false;

  Future<T> makeRequest<T>(Function f, {bool notify = true}) async {
    try {
      unSetError();
      _isLoading = true;
      if (notify) notifyListeners();
      T result = await Singleton().retry.retry(() => f(), retryIf: (e) {
        debugPrint("MakeRequest Retry! $e");
        return e is DioError &&
            (e.response == null ||
                e.response.statusCode == 401 &&
                    e.response.data['message_code'] == Constants.INVALID_TOKEN);
      });
      _isLoading = false;
      _madeSuccessfulRequest = true;
      if (notify) notifyListeners();
      debugPrint("makeRequest result $result");
      return result;
    } on DioError catch (e) {
      debugPrint("failed completely Grrrr $e");
      setResponseError(e);
      if (notify) notifyListeners();
    } catch (e) {
      debugPrint("Caught error $e");
      setError(
        errorMessage: "Something wen't wrong",
        errorCode: null,
        errorStatus: null,
      );
    }
    return null;
  }

  void setResponseError(DioError err) {
    debugPrint("setResponseError ${err.response?.data}");
    if (err.response == null) {
      setError(
        errorMessage: "Connection could not be made! ${err.error}",
        errorCode: null,
        errorStatus: null,
      );
    } else if (err.response.statusCode == 500) {
      setError(
        errorMessage: "Server Failure! Try again Later!",
        errorCode: null,
        errorStatus: err.response.statusCode,
      );
    } else if (err.response.statusCode == 404) {
      setError(
        errorMessage: "Not Found",
        errorCode: Constants.NOT_FOUND,
        errorStatus: err.response.statusCode,
      );
    } else if (err.response.statusCode == 400 &&
        err.response.data.containsKey("error") &&
        err.response.data["error"] == Constants.INVALID_GRANT) {
      String errorDescription = err.response.data["error_description"];
      setError(
        errorMessage: errorDescription.capitalize(),
        errorCode: Constants.INVALID_GRANT,
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
    debugPrint('Settinggg errorrrr $errorMessage');
    _isLoading = false;
    _hasError = true;
    _errorMessage = errorMessage;
    _errorCode = errorCode;
    _errorStatus = errorStatus;
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

  bool get madeSuccessfulRequest {
    return _madeSuccessfulRequest;
  }

  void unSetError() {
    _hasError = false;
    _errorMessage = null;
    _errorStatus = null;
    _errorCode = null;
  }

  void reset() {
    _madeSuccessfulRequest = false;
    _isLoading = false;
    unSetError();
  }
}
