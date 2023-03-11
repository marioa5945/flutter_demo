import './Service.dart';

class ServiceManager {
  static final ServiceManager _instance = ServiceManager._internal();
  factory ServiceManager() {
    return _instance;
  }

  ServiceManager._internal();

  Map serviceMap = {};

  int test = 1;

  void init() {
    print('init');
    print(serviceMap);
    print('hello world ${this.hashCode}');
  }

  void registService(Service service) {
    service.initDio();
    String key = service.serviceKey();
    serviceMap[key] = service;
    test += 1;
  }

  Service getService(String servieKey) {
    if (serviceMap.containsKey(servieKey)) {
      return serviceMap[servieKey];
    }
    throw Exception('服务尚未注册');
  }
}
