
import 'package:json_annotation/json_annotation.dart';

part 'videos_model.g.dart';

@JsonSerializable()
class VideoModel {
  String id;
  String? title;
  String? name;
  String? username;
  String? type;
  String? cover;
  String? avatar;
  String? date;

  VideoModel(
      {required this.id,
      required this.title,
      required this.name,
      required this.username,
      required this.type,
      required this.avatar,
      required this.date,
      required this.cover});

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}