import 'package:json_annotation/json_annotation.dart';

part 'BuyerShowModel.g.dart';

@JsonSerializable()
class BuyerShowModel {
  BuyerShowModel(this.title, this.cover, this.coverWidth, this.coverHeight,
      this.avatar, this.userName);

  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String cover;
  @JsonKey(name: 'cover_width', defaultValue: 0)
  final double coverWidth;
  @JsonKey(name: 'cover_height', defaultValue: 0)
  final double coverHeight;
  @JsonKey(name: 'create_avatar', defaultValue: '')
  final String avatar;
  @JsonKey(name: 'create_user', defaultValue: '')
  final String userName;

  factory BuyerShowModel.fromJson(Map<String, dynamic> json) =>
      _$BuyerShowModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuyerShowModelToJson(this);
}
