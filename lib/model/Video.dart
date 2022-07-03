// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

List<Video> videoFromJson(String str) =>
    List<Video>.from(json.decode(str).map((x) => Video.fromJson(x)));

String videoToJson(List<Video> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Video {
  Video({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.coverPicture,
  });

  int id;
  String title;
  String videoUrl;
  String coverPicture;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        videoUrl: json["videoUrl"],
        coverPicture: json["coverPicture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "videoUrl": videoUrl,
        "coverPicture": coverPicture,
      };
}
