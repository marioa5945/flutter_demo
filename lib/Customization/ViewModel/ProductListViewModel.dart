import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Models/ProductModel.dart';
import 'package:flutter_demo/Network/api/product_api.dart';
import 'package:flutter_demo/Network/http/BaseApi.dart';

class ProductListViewModel extends ChangeNotifier {
  final EasyRefreshController refreshController = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  final List<ProductModel> _productList = [];

  int _page = 1;
  final int _pageSize = 10;

  bool _isLoading = true;

  bool get isLoading => _isLoading && _productList.isEmpty;

  bool get isEmpty => _productList.isEmpty;

  void _updateProductList(List<ProductModel> list, bool isClear) {
    _isLoading = false;
    if (isClear) {
      _productList.clear();
    }
    _productList.addAll(list);
    notifyListeners();
  }

  /// 3d照片
  List<ProductModel> get photoProductList {
    var list = <ProductModel>[];
    for (final item in _productList) {
      if (item.productType == 2) {
        list.add(item);
        continue;
      }
      break;
    }
    return list;
  }

  /// 手办
  List<ProductModel> get handmadeProductList {
    int index = 0;
    for (index; index < _productList.length; index++) {
      if (_productList[index].productType == 1) {
        break;
      }
    }
    return _productList.sublist(index);
  }

  void refresh() {
    var api = ProductListApi(page: 1, pageSize: _pageSize);
    api.request(
      onSuccessed: (value) {
        var list = value ?? [];
        _page = 1;
        refreshController.finishRefresh();
        refreshController.resetFooter;
        _updateProductList(list, true);
      },
      onFailed: (p0) {},
    );
  }

  void loadMore() {
    var api = ProductListApi(page: _page + 1, pageSize: _pageSize);
    api.request(
      onSuccessed: (value) {
        var list = value ?? [];
        _page += 1;

        refreshController.finishLoad(list.length >= _pageSize
            ? IndicatorResult.success
            : IndicatorResult.noMore);
        _updateProductList(list, false);
      },
      onFailed: (p0) {},
    );
  }
}
