import 'package:dio/dio.dart';

class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = "";

  ServerError.withError({required DioError error}) {
    _handleError(error);
  }

  ServerError() {
    _errorCode = _kOther;
    _errorMessage = 'Connection failed due to internet connection';
  }

  final int _kConnectionTimeout = 1;
  final int _kSendTimeout = 2;
  final int _kReceiveTimeout = 3;
  final int _kResponse = 4;
  final int _kCancel = 5;
  final int _kOther = 6;

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        _errorCode = _kConnectionTimeout;
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        _errorCode = _kSendTimeout;

        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        _errorCode = _kReceiveTimeout;

        break;
      case DioErrorType.response:
        _errorMessage =
            "Received invalid status code: ${error.response!.statusCode}";
        _errorCode = _kResponse;
        break;
      case DioErrorType.cancel:
        _errorMessage = "Request was cancelled";
        _errorCode = _kCancel;
        break;
      case DioErrorType.other:
        _errorMessage = "Connection failed due to internet connection";
        _errorCode = _kOther;
        break;
    }
    return _errorMessage;
  }
}
