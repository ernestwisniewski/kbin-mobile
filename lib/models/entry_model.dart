import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class Entry {
  final int id;
  @JsonKey(name: '@id')
  final String apiUrl;
  final EntryMagazine magazine;
  final EntryUser user;
  final EntryImage? image;
  final String title;
  final String? url;
  final String? body;
  final int comments;
  final int uv;
  final int dv;
  final bool isAdult;
  final String type;

  Entry(
      {required this.id,
      required this.apiUrl,
      required this.magazine,
      required this.user,
      this.image,
      required this.title,
      this.url,
      this.body,
      required this.comments,
      required this.uv,
      required this.dv,
      required this.isAdult,
      required this.type});

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

  Map<String, dynamic> toJson() => _$EntryToJson(this);
}

@JsonSerializable()
class EntryMagazine {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String name;

  EntryMagazine({required this.apiUrl, required this.name});

  factory EntryMagazine.fromJson(Map<String, dynamic> json) =>
      _$EntryMagazineFromJson(json);

  Map<String, dynamic> toJson() => _$EntryMagazineToJson(this);
}

@JsonSerializable()
class EntryUser {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String username;

  EntryUser({required this.apiUrl, required this.username});

  factory EntryUser.fromJson(Map<String, dynamic> json) =>
      _$EntryUserFromJson(json);

  Map<String, dynamic> toJson() => _$EntryUserToJson(this);
}

@JsonSerializable()
class EntryImage {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String filePath;
  final int width;
  final int height;

  EntryImage(
      {required this.apiUrl,
      required this.filePath,
      required this.width,
      required this.height});

  factory EntryImage.fromJson(Map<String, dynamic> json) =>
      _$EntryImageFromJson(json);

  Map<String, dynamic> toJson() => _$EntryImageToJson(this);
}
