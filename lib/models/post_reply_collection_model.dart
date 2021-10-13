import 'package:json_annotation/json_annotation.dart';

part 'post_reply_collection_model.g.dart';

@JsonSerializable()
class ReplyCollectionItem {
  final int id;
  @JsonKey(name: '@id')
  final String apiUrl;
  final PostPostReplyUser user;
  final PostReplyImage? image;
  final String body;
  final int uv;
  final DateTime createdAt;
  final DateTime lastActive;

  ReplyCollectionItem(
      {required this.id,
      required this.apiUrl,
      required this.user,
      this.image,
      required this.body,
      required this.uv,
      required this.createdAt,
      required this.lastActive});

  factory ReplyCollectionItem.fromJson(Map<String, dynamic> json) =>
      _$ReplyCollectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyCollectionItemToJson(this);
}

@JsonSerializable()
class PostPostReplyUser {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String username;
  final PostReplyImage? avatar;

  PostPostReplyUser(
      {required this.apiUrl, required this.username, this.avatar});

  factory PostPostReplyUser.fromJson(Map<String, dynamic> json) =>
      _$PostPostReplyUserFromJson(json);

  Map<String, dynamic> toJson() => _$PostPostReplyUserToJson(this);
}

@JsonSerializable()
class PostReplyImage {
  @JsonKey(name: '@id')
  final String apiUrl;
  final String filePath;
  final int width;
  final int height;

  PostReplyImage(
      {required this.apiUrl,
      required this.filePath,
      required this.width,
      required this.height});

  factory PostReplyImage.fromJson(Map<String, dynamic> json) =>
      _$PostReplyImageFromJson(json);

  Map<String, dynamic> toJson() => _$PostReplyImageToJson(this);
}

enum SortOptions { hot, newest, top, active, commented }

extension ParseToString on SortOptions {
  String toParam() {
    return toString().split('.').last;
  }
}
