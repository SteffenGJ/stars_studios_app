// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      videoId: json['videoId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'videoId': instance.videoId,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
    };
