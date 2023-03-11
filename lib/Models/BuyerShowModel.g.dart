// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BuyerShowModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyerShowModel _$BuyerShowModelFromJson(Map<String, dynamic> json) =>
    BuyerShowModel(
      json['title'] as String? ?? '',
      json['cover'] as String? ?? '',
      (json['cover_width'] as num?)?.toDouble() ?? 0,
      (json['cover_height'] as num?)?.toDouble() ?? 0,
      json['create_avatar'] as String? ?? '',
      json['create_user'] as String? ?? '',
    );

Map<String, dynamic> _$BuyerShowModelToJson(BuyerShowModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'cover': instance.cover,
      'cover_width': instance.coverWidth,
      'cover_height': instance.coverHeight,
      'create_avatar': instance.avatar,
      'create_user': instance.userName,
    };
