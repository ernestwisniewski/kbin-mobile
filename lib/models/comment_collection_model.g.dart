// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentCollectionItem _$CommentCollectionItemFromJson(
        Map<String, dynamic> json) =>
    CommentCollectionItem(
      id: json['id'] as int,
      apiUrl: json['@id'] as String,
      user: CommentCollectionItemUser.fromJson(
          json['user'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : CommentCollectionItemImage.fromJson(
              json['image'] as Map<String, dynamic>),
      body: json['body'] as String,
      uv: json['uv'] as int,
      dv: json['dv'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActive: DateTime.parse(json['lastActive'] as String),
    );

Map<String, dynamic> _$CommentCollectionItemToJson(
        CommentCollectionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      '@id': instance.apiUrl,
      'user': instance.user,
      'image': instance.image,
      'body': instance.body,
      'uv': instance.uv,
      'dv': instance.dv,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastActive': instance.lastActive.toIso8601String(),
    };

CommentCollectionItemUser _$CommentCollectionItemUserFromJson(
        Map<String, dynamic> json) =>
    CommentCollectionItemUser(
      apiUrl: json['@id'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] == null
          ? null
          : CommentCollectionItemImage.fromJson(
              json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentCollectionItemUserToJson(
        CommentCollectionItemUser instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'username': instance.username,
      'avatar': instance.avatar,
    };

CommentCollectionItemImage _$CommentCollectionItemImageFromJson(
        Map<String, dynamic> json) =>
    CommentCollectionItemImage(
      apiUrl: json['@id'] as String,
      filePath: json['filePath'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$CommentCollectionItemImageToJson(
        CommentCollectionItemImage instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'filePath': instance.filePath,
      'width': instance.width,
      'height': instance.height,
    };
