import 'package:json_annotation/json_annotation.dart';

part 'ProductModel.g.dart';

@JsonSerializable()
class ProductModel {
  ProductModel(this.id, this.productType, this.cover, this.productName);

  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(name: 'product_type', defaultValue: 1)
  final int productType;
  @JsonKey(name: 'product_front_pic', defaultValue: '')
  final String cover;
  @JsonKey(name: 'product_name', defaultValue: '')
  final String productName;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
