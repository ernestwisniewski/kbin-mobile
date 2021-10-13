import 'package:json_annotation/json_annotation.dart';

part 'comment_collection_model.g.dart';

@JsonSerializable()
class CommentCollectionItem {
  final int id;
  @JsonKey(name: '@id')
  final String apiUrl;
  final CommentCollectionItemMagazine magazine;
  final CommentCollectionItemEntry entry;
  final CommentCollectionItemUser user;
  final CommentCollectionItemImage? image;
  final String body;
  final int uv;
  final int dv;
  final DateTime createdAt;
  final DateTime lastActive;

  CommentCollectionItem(
      {required this.id,
      required this.apiUrl,
      required this.magazine,
      required this.entry,
      required this.user,
      this.image,
      required this.body,
      required this.uv,
      required this.dv,
      required this.createdAt,
      required this.lastActive});

  factory CommentCollectionItem.fromJson(Map<String, dynamic> json) =>
      _$CommentCollectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$CommentCollectionItemToJson(this);
}

@JsonSerializable()
class CommentCollectionItemMagazine {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String name;

  CommentCollectionItemMagazine({required this.apiUrl, required this.name});

  factory CommentCollectionItemMagazine.fromJson(Map<String, dynamic> json) =>
      _$CommentCollectionItemMagazineFromJson(json);

  Map<String, dynamic> toJson() => _$CommentCollectionItemMagazineToJson(this);
}

@JsonSerializable()
class CommentCollectionItemEntry {
  @JsonKey(name: '@id')
  final String apiUrl;
  final int id;
  final String title;

  CommentCollectionItemEntry(
      {required this.apiUrl, required this.id, required this.title});

  factory CommentCollectionItemEntry.fromJson(Map<String, dynamic> json) =>
      _$CommentCollectionItemEntryFromJson(json);

  Map<String, dynamic> toJson() => _$CommentCollectionItemEntryToJson(this);
}

@JsonSerializable()
class CommentCollectionItemUser {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String username;
  final CommentCollectionItemImage? avatar;

  CommentCollectionItemUser(
      {required this.apiUrl, required this.username, this.avatar});

  factory CommentCollectionItemUser.fromJson(Map<String, dynamic> json) =>
      _$CommentCollectionItemUserFromJson(json);

  Map<String, dynamic> toJson() => _$CommentCollectionItemUserToJson(this);
}

@JsonSerializable()
class CommentCollectionItemImage {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String filePath;
  final int width;
  final int height;

  CommentCollectionItemImage(
      {required this.apiUrl,
      required this.filePath,
      required this.width,
      required this.height});

  factory CommentCollectionItemImage.fromJson(Map<String, dynamic> json) =>
      _$CommentCollectionItemImageFromJson(json);

  Map<String, dynamic> toJson() => _$CommentCollectionItemImageToJson(this);
}
