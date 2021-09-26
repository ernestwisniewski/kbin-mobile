// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCollectionItem _$PostCollectionItemFromJson(Map<String, dynamic> json) =>
    PostCollectionItem(
      id: json['id'] as int,
      apiUrl: json['@id'] as String,
      magazine: PostCollectionItemMagazine.fromJson(
          json['magazine'] as Map<String, dynamic>),
      user:
          PostCollectionItemUser.fromJson(json['user'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : PostCollectionItemImage.fromJson(
              json['image'] as Map<String, dynamic>),
      body: json['body'] as String?,
      replies: json['comments'] as int,
      uv: json['uv'] as int,
      dv: json['dv'] as int,
      isAdult: json['isAdult'] as bool,
    );

Map<String, dynamic> _$PostCollectionItemToJson(PostCollectionItem instance) =>
    <String, dynamic>{
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
    };

PostCollectionItemMagazine _$PostCollectionItemMagazineFromJson(
        Map<String, dynamic> json) =>
    PostCollectionItemMagazine(
      apiUrl: json['@id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PostCollectionItemMagazineToJson(
        PostCollectionItemMagazine instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'name': instance.name,
    };

PostCollectionItemUser _$PostCollectionItemUserFromJson(
        Map<String, dynamic> json) =>
    PostCollectionItemUser(
      apiUrl: json['@id'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$PostCollectionItemUserToJson(
        PostCollectionItemUser instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'username': instance.username,
    };

PostCollectionItemImage _$PostCollectionItemImageFromJson(
        Map<String, dynamic> json) =>
    PostCollectionItemImage(
      apiUrl: json['@id'] as String,
      filePath: json['filePath'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$PostCollectionItemImageToJson(
        PostCollectionItemImage instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'filePath': instance.filePath,
      'width': instance.width,
      'height': instance.height,
    };
