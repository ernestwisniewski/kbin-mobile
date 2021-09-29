// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostItem _$PostItemFromJson(Map<String, dynamic> json) => PostItem(
      id: json['id'] as int,
      apiUrl: json['@id'] as String,
      magazine:
          PostItemMagazine.fromJson(json['magazine'] as Map<String, dynamic>),
      user: PostItemUser.fromJson(json['user'] as Map<String, dynamic>),
      body: json['body'] as String,
      image: json['image'] == null
          ? null
          : PostItemImage.fromJson(json['image'] as Map<String, dynamic>),
      replies: json['comments'] as int,
      uv: json['uv'] as int,
      dv: json['dv'] as int,
      isAdult: json['isAdult'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActive: DateTime.parse(json['lastActive'] as String),
    );

Map<String, dynamic> _$PostItemToJson(PostItem instance) => <String, dynamic>{
      'id': instance.id,
      '@id': instance.apiUrl,
      'magazine': instance.magazine,
      'user': instance.user,
      'image': instance.image,
      'body': instance.body,
      'comments': instance.replies,
      'uv': instance.uv,
      'dv': instance.dv,
      'isAdult': instance.isAdult,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastActive': instance.lastActive.toIso8601String(),
    };

PostItemMagazine _$PostItemMagazineFromJson(Map<String, dynamic> json) =>
    PostItemMagazine(
      apiUrl: json['@id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PostItemMagazineToJson(PostItemMagazine instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'name': instance.name,
    };

PostItemUser _$PostItemUserFromJson(Map<String, dynamic> json) => PostItemUser(
      apiUrl: json['@id'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] == null
          ? null
          : PostItemImage.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostItemUserToJson(PostItemUser instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'username': instance.username,
      'avatar': instance.avatar,
    };

PostItemImage _$PostItemImageFromJson(Map<String, dynamic> json) =>
    PostItemImage(
      apiUrl: json['@id'] as String,
      filePath: json['filePath'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$PostItemImageToJson(PostItemImage instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'filePath': instance.filePath,
      'width': instance.width,
      'height': instance.height,
    };
