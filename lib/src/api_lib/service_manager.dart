import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:paper/src/resources/strings/app_strings.dart';

///[ServiceManager] manages to create Dio object.
class ServiceManager {
  static ServiceManager? _serviceManager;
  static final Map<String, String> _defaultHeaders = {
    AppStrings.X_API_KEY_HEADER_KEY: AppStrings.API_KEY,
  };
  ServiceManager._instance();
  /// Method to get Singleton instance of the class
  static ServiceManager get(){
    _serviceManager??=ServiceManager._instance();
    return _serviceManager!;
  }

   Dio getDioClient() {
    /// To get Dio for client
    final dio = Dio();
    HashMap<String, String> hashMap = HashMap();
    hashMap['Content-Type'] = 'application/json; charset=utf-8';
    hashMap['Accept'] = 'application/json; charset=utf-8';
    _defaultHeaders.addAll(hashMap);
    dio
      ..options.baseUrl = AppStrings.BASE_URL
      ..options.headers = _defaultHeaders;

    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    return dio;
  }
}
