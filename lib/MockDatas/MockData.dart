import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_demo/Models/BuyerShowModel.dart';

class BuyerShowResult {
  BuyerShowResult(this.total, this.page, this.pageSize, this.dataList);

  final int total;
  final int page;
  final int pageSize;
  List<BuyerShowModel>? dataList;

  BuyerShowResult.fromJson(Map<String, dynamic> json)
      : total = json['total'],
        page = json['page'],
        pageSize = json['pageSize'] {
    if (json['data_list'] != null) {
      var list = <BuyerShowModel>[];
      json['data_list'].forEach((v) {
        list.add(BuyerShowModel.fromJson(v));
      });
      dataList = list;
    }
  }
}

Future<String> _loadJson(String assets) async {
  return await rootBundle.loadString(assets);
}

Future<List<BuyerShowModel>> buyershowList() async {
  String jsonString = await _loadJson('assets/buyershows.json');
  final jsonResponse = json.decode(jsonString);
  BuyerShowResult result = BuyerShowResult.fromJson(jsonResponse);
  return result.dataList ?? [];
}
