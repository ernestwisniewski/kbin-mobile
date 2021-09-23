import 'package:json_annotation/json_annotation.dart';

part 'entry_item_model.g.dart';

@JsonSerializable()
class EntryItem {
  final int id;
  @JsonKey(name: '@id')
  final String apiUrl;
  final EntryItemMagazine magazine;
  final EntryItemUser user;
  final EntryItemImage? image;
  final EntryItemDomain? domain;
  final String title;
  final String? url;
  final String? body;
  final int comments;
  final int uv;
  final int dv;
  final bool isAdult;
  final String type;
  final int views;
  final int score;
  final DateTime createdAt;

  EntryItem(
      {required this.id,
      required this.apiUrl,
      required this.magazine,
      required this.user,
      this.image,
      this.domain,
      required this.title,
      this.url,
      this.body,
      required this.comments,
      required this.uv,
      required this.dv,
      required this.isAdult,
      required this.type,
      required this.views,
      required this.score,
      required this.createdAt,
      });

  factory EntryItem.fromJson(Map<String, dynamic> json) => _$EntryItemFromJson(json);

  Map<String, dynamic> toJson() => _$EntryItemToJson(this);
}

@JsonSerializable()
class EntryItemMagazine {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String name;

  EntryItemMagazine({required this.apiUrl, required this.name});

  factory EntryItemMagazine.fromJson(Map<String, dynamic> json) =>
      _$EntryItemMagazineFromJson(json);

  Map<String, dynamic> toJson() => _$EntryItemMagazineToJson(this);
}

@JsonSerializable()
class EntryItemUser {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String username;

  EntryItemUser({required this.apiUrl, required this.username});

  factory EntryItemUser.fromJson(Map<String, dynamic> json) =>
      _$EntryItemUserFromJson(json);

  Map<String, dynamic> toJson() => _$EntryItemUserToJson(this);
}

@JsonSerializable()
class EntryItemImage {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String filePath;
  final int width;
  final int height;

  EntryItemImage(
      {required this.apiUrl,
      required this.filePath,
      required this.width,
      required this.height});

  factory EntryItemImage.fromJson(Map<String, dynamic> json) =>
      _$EntryItemImageFromJson(json);

  Map<String, dynamic> toJson() => _$EntryItemImageToJson(this);
}

@JsonSerializable()
class EntryItemDomain {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String name;
  final int entryCount;

  EntryItemDomain({required this.apiUrl, required this.name, required this.entryCount});

  factory EntryItemDomain.fromJson(Map<String, dynamic> json) =>
      _$EntryItemDomainFromJson(json);

  Map<String, dynamic> toJson() => _$EntryItemDomainToJson(this);
}
