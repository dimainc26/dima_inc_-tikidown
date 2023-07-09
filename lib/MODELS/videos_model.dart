
import 'package:json_annotation/json_annotation.dart';

part 'videos_model.g.dart';

@JsonSerializable()
class VideoModel {
  String? id;
  String? title;
  String? name;
  String? username;
  String? type;
  String? cover;
  String? avatar;
  String? date;

  VideoModel(
      {required id,
      required title,
      required name,
      required username,
      required type,
      required avatar,
      required date,
      required cover});

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}