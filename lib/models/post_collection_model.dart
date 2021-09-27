import 'package:json_annotation/json_annotation.dart';

part 'post_collection_model.g.dart';

@JsonSerializable()
class PostCollectionItem {
  final int id;
  @JsonKey(name: '@id')
  final String apiUrl;
  final PostCollectionItemMagazine magazine;
  final PostCollectionItemUser user;
  final PostCollectionItemImage? image;
  final String body;
  @JsonKey(name: 'comments')
  final int replies;
  final int uv;
  final int dv;
  final bool isAdult;
  final DateTime createdAt;
  final DateTime lastActive;

  PostCollectionItem(
      {required this.id,
      required this.apiUrl,
      required this.magazine,
      required this.user,
      required this.body,
      this.image,
      required this.replies,
      required this.uv,
      required this.dv,
      required this.isAdult,
      required this.createdAt,
      required this.lastActive});

  factory PostCollectionItem.fromJson(Map<String, dynamic> json) =>
      _$PostCollectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$PostCollectionItemToJson(this);
}

@JsonSerializable()
class PostCollectionItemMagazine {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String name;

  PostCollectionItemMagazine({required this.apiUrl, required this.name});

  factory PostCollectionItemMagazine.fromJson(Map<String, dynamic> json) =>
      _$PostCollectionItemMagazineFromJson(json);

  Map<String, dynamic> toJson() => _$PostCollectionItemMagazineToJson(this);
}

@JsonSerializable()
class PostCollectionItemUser {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String username;
  final PostCollectionItemImage? avatar;

  PostCollectionItemUser(
      {required this.apiUrl, required this.username, this.avatar});

  factory PostCollectionItemUser.fromJson(Map<String, dynamic> json) =>
      _$PostCollectionItemUserFromJson(json);

  Map<String, dynamic> toJson() => _$PostCollectionItemUserToJson(this);
}

@JsonSerializable()
class PostCollectionItemImage {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String filePath;
  final int width;
  final int height;

  PostCollectionItemImage(
      {required this.apiUrl,
      required this.filePath,
      required this.width,
      required this.height});

  factory PostCollectionItemImage.fromJson(Map<String, dynamic> json) =>
      _$PostCollectionItemImageFromJson(json);

  Map<String, dynamic> toJson() => _$PostCollectionItemImageToJson(this);
}
