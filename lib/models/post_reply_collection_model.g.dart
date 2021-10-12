// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_reply_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyCollectionItem _$ReplyCollectionItemFromJson(Map<String, dynamic> json) =>
    ReplyCollectionItem(
      id: json['id'] as int,
      apiUrl: json['@id'] as String,
      user: PostPostReplyUser.fromJson(json['user'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : PostReplyImage.fromJson(json['image'] as Map<String, dynamic>),
      body: json['body'] as String,
      uv: json['uv'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActive: DateTime.parse(json['lastActive'] as String),
    );

Map<String, dynamic> _$ReplyCollectionItemToJson(
        ReplyCollectionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      '@id': instance.apiUrl,
      'user': instance.user,
      'image': instance.image,
      'body': instance.body,
      'uv': instance.uv,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastActive': instance.lastActive.toIso8601String(),
    };

PostPostReplyUser _$PostPostReplyUserFromJson(Map<String, dynamic> json) =>
    PostPostReplyUser(
      apiUrl: json['@id'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] == null
          ? null
          : PostReplyImage.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostPostReplyUserToJson(PostPostReplyUser instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'username': instance.username,
      'avatar': instance.avatar,
    };

PostReplyImage _$PostReplyImageFromJson(Map<String, dynamic> json) =>
    PostReplyImage(
      apiUrl: json['@id'] as String,
      filePath: json['filePath'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$PostReplyImageToJson(PostReplyImage instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'filePath': instance.filePath,
      'width': instance.width,
      'height': instance.height,
    };
