import 'package:json_annotation/json_annotation.dart';

part 'post_comment_collection_model.g.dart';

@JsonSerializable()
class PostCommentsItem {
  final int id;
  @JsonKey(name: '@id')
  final String apiUrl;
  final EntryCommentUser user;
  final EntryCommentImage? image;
  final String body;
  final int uv;
  final DateTime createdAt;
  final DateTime lastActive;

  PostCommentsItem(
      {required this.id,
      required this.apiUrl,
      required this.user,
      this.image,
      required this.body,
      required this.uv,
      required this.createdAt,
      required this.lastActive});

  factory PostCommentsItem.fromJson(Map<String, dynamic> json) =>
      _$PostCommentsItemFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommentsItemToJson(this);
}

@JsonSerializable()
class EntryCommentUser {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String username;
  final EntryCommentImage? avatar;

  EntryCommentUser({required this.apiUrl, required this.username, this.avatar});

  factory EntryCommentUser.fromJson(Map<String, dynamic> json) =>
      _$EntryCommentUserFromJson(json);

  Map<String, dynamic> toJson() => _$EntryCommentUserToJson(this);
}

@JsonSerializable()
class EntryCommentImage {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String filePath;
  final int width;
  final int height;

  EntryCommentImage(
      {required this.apiUrl,
      required this.filePath,
      required this.width,
      required this.height});

  factory EntryCommentImage.fromJson(Map<String, dynamic> json) =>
      _$EntryCommentImageFromJson(json);

  Map<String, dynamic> toJson() => _$EntryCommentImageToJson(this);
}
