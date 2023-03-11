// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as int? ?? 0,
      json['product_type'] as int? ?? 1,
      json['product_front_pic'] as String? ?? '',
      json['product_name'] as String? ?? '',
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_type': instance.productType,
      'product_front_pic': instance.cover,
      'product_name': instance.productName,
    };
