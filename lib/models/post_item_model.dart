import 'package:json_annotation/json_annotation.dart';

part 'post_item_model.g.dart';

@JsonSerializable()
class PostItem {
  final int id;
  @JsonKey(name: '@id')
  final String apiUrl;
  final PostItemMagazine magazine;
  final PostItemUser user;
  final PostItemImage? image;
  final String body;
  @JsonKey(name: 'comments')
  final int replies;
  final int uv;
  final int dv;
  final bool isAdult;
  final DateTime createdAt;
  final DateTime lastActive;

  PostItem(
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

  factory PostItem.fromJson(Map<String, dynamic> json) =>
      _$PostItemFromJson(json);

  Map<String, dynamic> toJson() => _$PostItemToJson(this);
}

@JsonSerializable()
class PostItemMagazine {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String name;

  PostItemMagazine({required this.apiUrl, required this.name});

  factory PostItemMagazine.fromJson(Map<String, dynamic> json) =>
      _$PostItemMagazineFromJson(json);

  Map<String, dynamic> toJson() => _$PostItemMagazineToJson(this);
}

@JsonSerializable()
class PostItemUser {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String username;
  final PostItemImage? avatar;

  PostItemUser({required this.apiUrl, required this.username, this.avatar});

  factory PostItemUser.fromJson(Map<String, dynamic> json) =>
      _$PostItemUserFromJson(json);

  Map<String, dynamic> toJson() => _$PostItemUserToJson(this);
}

@JsonSerializable()
class PostItemImage {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String filePath;
  final int width;
  final int height;

  PostItemImage(
      {required this.apiUrl,
      required this.filePath,
      required this.width,
      required this.height});

  factory PostItemImage.fromJson(Map<String, dynamic> json) =>
      _$PostItemImageFromJson(json);

  Map<String, dynamic> toJson() => _$PostItemImageToJson(this);
}
