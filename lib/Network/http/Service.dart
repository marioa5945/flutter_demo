import 'package:dio/dio.dart';

class Service {
  final Dio dio = Dio();

  late var _baseUrl = "";

  set baseUrl(value) {
    if (_baseUrl == value) {
      return;
    }
    _baseUrl = value;
    dio.options.baseUrl = _baseUrl;
  }

  get baseUrl => _baseUrl;

  Map<String, dynamic>? serviceHeader() {
    return null;
  }

  Map<String, dynamic>? serviceQuery() {
    return null;
  }

  Map<String, dynamic>? serviceBody() {
    return null;
  }

  /// dio 默认设置，由具体的服务去实现
  void initDio() {}

  /// 数据加工
  Map<String, dynamic> responseFactory(Map<String, dynamic> dataMap) {
    return dataMap;
  }

  String errorFactory(DioError error) {
    String errorMessage;
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        errorMessage = "Connection timeout";
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = "Receive timeout";
        break;
      case DioErrorType.sendTimeout:
        errorMessage = "Send timeout";
        break;
      default:
        errorMessage = error.message ?? "未知错误";
    }
    return errorMessage;
  }

  String serviceKey() {
    return "";
  }
}
