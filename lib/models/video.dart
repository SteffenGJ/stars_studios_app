import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  final String videoId;
  final String title;
  final String description;
  final String url;
  late final String videoUrl = "https://www.youtube.com/watch?v=$videoId";

  Video({
    required this.videoId,
    required this.title,
    required this.description,
    required this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
