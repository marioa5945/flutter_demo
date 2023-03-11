import 'dart:convert';

import './Service.dart';
import 'package:dio/dio.dart';
import './ServiceManager.dart';

enum RequestMethod { get, post }

typedef HttpParams = Map<String, dynamic>;
typedef HttpHeader = Map<String, dynamic>;

class BaseApi<Model> {
  String serviceKey() {
    return "";
  }

  String uri() {
    return "";
  }

  RequestMethod method() {
    return RequestMethod.get;
  }

  HttpParams get getApiQuery => {};

  HttpParams get getApiBody => {};

  HttpHeader get getApiHeader => {};

  Model? toModel(Map<String, dynamic> json) {
    throw Exception('子类重写');
  }
}

class ApiError {
  ApiError.system(this.message) : code = -999999;
  ApiError.server({required this.code, this.message});

  final int code;
  final String? message;

  @override
  String toString() {
    return message ?? "";
  }
}

extension ApiRequest<Model> on BaseApi<Model> {
  void request(
      {required Function(Model?) onSuccessed,
      required Function(ApiError) onFailed}) async {
    Service service;
    if (ServiceManager().serviceMap.containsKey(serviceKey())) {
      service = ServiceManager().getService(serviceKey());
    } else {
      throw Exception('服务尚未注册');
    }

    Dio dio = service.dio;

    Map<String, dynamic>? headerParams = {};

    var globalHeaderParams = service.serviceHeader();
    if (globalHeaderParams != null) {
      headerParams.addAll(globalHeaderParams);
    }
    headerParams.addAll(getApiHeader);

    Map<String, dynamic>? queryParams = {};
    var globalQueryParams = service.serviceQuery();
    if (globalQueryParams != null) {
      queryParams.addAll(globalQueryParams);
    }
    queryParams.addAll(getApiQuery);

    Map<String, dynamic>? bodyParams = {};
    var globalBodyParams = service.serviceBody();
    if (globalBodyParams != null) {
      bodyParams.addAll(globalBodyParams);
    }
    bodyParams.addAll(getApiBody);

    Options options = Options(headers: headerParams);
    Response? response;
    try {
      switch (method()) {
        case RequestMethod.get:
          response = await dio.get(uri(),
              queryParameters: queryParams, options: options);
          break;
        case RequestMethod.post:
          response = await dio.post(uri(),
              data: bodyParams, queryParameters: queryParams, options: options);
          break;
      }
    } on DioError catch (error) {
      onFailed(ApiError.system(service.errorFactory(error)));
    }
    if (response != null && response.data != null) {
      String dataStr = json.encode(response.data);
      Map<String, dynamic> dataMap = json.decode(dataStr);
      dataMap = service.responseFactory(dataMap);
      int code = dataMap['code'];
      if (code == 0) {
        Model? resModel = toModel(dataMap);
        onSuccessed(resModel);
      } else {
        String message = dataMap['msg'] ?? "";
        onFailed(ApiError.server(code: code, message: message));
      }
    }
  }
}
