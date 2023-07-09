// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      id: json['id'],
      title: json['title'],
      name: json['name'],
      username: json['username'],
      type: json['type'],
      avatar: json['avatar'],
      date: json['date'],
      cover: json['cover'],
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'name': instance.name,
      'username': instance.username,
      'type': instance.type,
      'cover': instance.cover,
      'avatar': instance.avatar,
      'date': instance.date,
    };
