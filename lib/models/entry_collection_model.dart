import 'package:json_annotation/json_annotation.dart';

part 'entry_collection_model.g.dart';

@JsonSerializable()
class EntryCollectionItem {
  final int id;
  @JsonKey(name: '@id')
  final String apiUrl;
  final EntryCollectionItemMagazine magazine;
  final EntryCollectionItemUser user;
  final EntryCollectionItemImage? image;
  final EntryCollectionItemDomain? domain;
  final String title;
  final String? url;
  final String? body;
  final int comments;
  final int uv;
  final int dv;
  final bool isAdult;
  final String type;

  EntryCollectionItem(
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
      required this.type});

  factory EntryCollectionItem.fromJson(Map<String, dynamic> json) =>
      _$EntryCollectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$EntryCollectionItemToJson(this);
}

@JsonSerializable()
class EntryCollectionItemMagazine {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String name;

  EntryCollectionItemMagazine({required this.apiUrl, required this.name});

  factory EntryCollectionItemMagazine.fromJson(Map<String, dynamic> json) =>
      _$EntryCollectionItemMagazineFromJson(json);

  Map<String, dynamic> toJson() => _$EntryCollectionItemMagazineToJson(this);
}

@JsonSerializable()
class EntryCollectionItemUser {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String username;

  EntryCollectionItemUser({required this.apiUrl, required this.username});

  factory EntryCollectionItemUser.fromJson(Map<String, dynamic> json) =>
      _$EntryCollectionItemUserFromJson(json);

  Map<String, dynamic> toJson() => _$EntryCollectionItemUserToJson(this);
}

@JsonSerializable()
class EntryCollectionItemImage {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String filePath;
  final int width;
  final int height;

  EntryCollectionItemImage(
      {required this.apiUrl,
      required this.filePath,
      required this.width,
      required this.height});

  factory EntryCollectionItemImage.fromJson(Map<String, dynamic> json) =>
      _$EntryCollectionItemImageFromJson(json);

  Map<String, dynamic> toJson() => _$EntryCollectionItemImageToJson(this);
}

@JsonSerializable()
class EntryCollectionItemDomain {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String name;

  EntryCollectionItemDomain({required this.apiUrl, required this.name});

  factory EntryCollectionItemDomain.fromJson(Map<String, dynamic> json) =>
      _$EntryCollectionItemDomainFromJson(json);

  Map<String, dynamic> toJson() => _$EntryCollectionItemDomainToJson(this);
}
