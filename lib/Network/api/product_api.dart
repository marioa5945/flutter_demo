import 'package:flutter_demo/Models/ProductModel.dart';
import 'package:flutter_demo/Network/http/BaseApi.dart';
import 'package:flutter_demo/Network/service/XmhService.dart';

class ProductListApi extends BaseApi<List<ProductModel>> {
  ProductListApi({required this.page, required this.pageSize});
  final int page;
  final int pageSize;

  @override
  String serviceKey() {
    return XmhServiceKey;
  }

  @override
  RequestMethod method() {
    return RequestMethod.get;
  }

  @override
  String uri() {
    return '/magicbox/product/getProductList';
  }

  @override
  HttpParams get getApiQuery => {'page': page, 'pageSize': pageSize};

  @override
  List<ProductModel>? toModel(Map<String, dynamic> json) {
    if (json['data'] != null && json['data']['data_list'] != null) {
      var dataList = json['data']['data_list'];
      List<ProductModel> list = [];
      dataList.forEach((v) {
        list.add(ProductModel.fromJson(v));
      });
      return list;
    }
    return null;
  }
}
