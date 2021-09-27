// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentsItem _$PostCommentsItemFromJson(Map<String, dynamic> json) =>
    PostCommentsItem(
      id: json['id'] as int,
      apiUrl: json['@id'] as String,
      user: EntryCommentUser.fromJson(json['user'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : EntryCommentImage.fromJson(json['image'] as Map<String, dynamic>),
      body: json['body'] as String,
      uv: json['uv'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActive: DateTime.parse(json['lastActive'] as String),
    );

Map<String, dynamic> _$PostCommentsItemToJson(PostCommentsItem instance) =>
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

EntryCommentUser _$EntryCommentUserFromJson(Map<String, dynamic> json) =>
    EntryCommentUser(
      apiUrl: json['@id'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] == null
          ? null
          : EntryCommentImage.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EntryCommentUserToJson(EntryCommentUser instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'username': instance.username,
      'avatar': instance.avatar,
    };

EntryCommentImage _$EntryCommentImageFromJson(Map<String, dynamic> json) =>
    EntryCommentImage(
      apiUrl: json['@id'] as String,
      filePath: json['filePath'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$EntryCommentImageToJson(EntryCommentImage instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'filePath': instance.filePath,
      'width': instance.width,
      'height': instance.height,
    };
