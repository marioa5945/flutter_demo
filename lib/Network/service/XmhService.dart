import '../http/Service.dart';
import 'package:dio/dio.dart';

const String XmhServiceKey = "_XmhServiceKey";

class XmhService extends Service {
  @override
  String serviceKey() {
    return XmhServiceKey;
  }

  @override
  void initDio() {
    dio.options.headers = {
      'Accept': 'application/json,*/*',
      'Content-Type': 'application/json'
    };
    dio.options.baseUrl = 'https://platform.upmobius.com';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.contentType = 'application/json';

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
