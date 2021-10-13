import 'package:json_annotation/json_annotation.dart';

part 'magazine_collection_model.g.dart';

@JsonSerializable()
class MagazineCollectionItem {
  @JsonKey(name: '@id')
  final String apiUrl;
  final MagazineCollectionItemUser user;
  @JsonKey(name: 'cover')
  final MagazineCollectionItemImage? image;
  final String name;
  final String title;
  final String? description;
  final int subscriptionsCount;
  final int entryCount;
  final int entryCommentCount;
  final int postCount;
  final int postCommentCount;
  final bool isAdult;

  MagazineCollectionItem({
    required this.apiUrl,
    required this.user,
    this.image,
    required this.name,
    required this.title,
    this.description,
    required this.subscriptionsCount,
    required this.entryCount,
    required this.entryCommentCount,
    required this.postCount,
    required this.postCommentCount,
    required this.isAdult,
  });

  factory MagazineCollectionItem.fromJson(Map<String, dynamic> json) =>
      _$MagazineCollectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$MagazineCollectionItemToJson(this);
}

@JsonSerializable()
class MagazineCollectionItemUser {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String username;

  MagazineCollectionItemUser({required this.apiUrl, required this.username});

  factory MagazineCollectionItemUser.fromJson(Map<String, dynamic> json) =>
      _$MagazineCollectionItemUserFromJson(json);

  Map<String, dynamic> toJson() => _$MagazineCollectionItemUserToJson(this);
}

@JsonSerializable()
class MagazineCollectionItemImage {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String filePath;
  final int width;
  final int height;

  MagazineCollectionItemImage(
      {required this.apiUrl,
      required this.filePath,
      required this.width,
      required this.height});

  factory MagazineCollectionItemImage.fromJson(Map<String, dynamic> json) =>
      _$MagazineCollectionItemImageFromJson(json);

  Map<String, dynamic> toJson() => _$MagazineCollectionItemImageToJson(this);
}
