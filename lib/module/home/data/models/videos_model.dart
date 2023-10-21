// To parse this JSON data, do
//
//     final videos = videosFromJson(jsonString);

import 'dart:convert';

List<Videos> videosFromJson(String str) =>
    List<Videos>.from(json.decode(str).map((x) => Videos.fromJson(x)));

String videosToJson(List<Videos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Videos {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  Type? type;
  bool? official;
  DateTime? publishedAt;
  String? id;

  Videos({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: typeValues.map[json["type"]],
        official: json["official"],
        publishedAt: json["published_at"] != null
            ? DateTime.parse(json["published_at"])
            : null,
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": typeValues.reverse[type],
        "official": official,
        "published_at": publishedAt?.toIso8601String(),
        "id": id,
      };
}

enum Type { BEHIND_THE_SCENES, CLIP, FEATURETTE, TEASER, TRAILER }

final typeValues = EnumValues({
  "Behind the Scenes": Type.BEHIND_THE_SCENES,
  "Clip": Type.CLIP,
  "Featurette": Type.FEATURETTE,
  "Teaser": Type.TEASER,
  "Trailer": Type.TRAILER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
