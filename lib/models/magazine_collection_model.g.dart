// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagazineCollectionItem _$MagazineCollectionItemFromJson(
        Map<String, dynamic> json) =>
    MagazineCollectionItem(
      apiUrl: json['@id'] as String,
      user: MagazineCollectionItemUser.fromJson(
          json['user'] as Map<String, dynamic>),
      image: json['cover'] == null
          ? null
          : MagazineCollectionItemImage.fromJson(
              json['cover'] as Map<String, dynamic>),
      name: json['name'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      subscriptionsCount: json['subscriptionsCount'] as int,
      entryCount: json['entryCount'] as int,
      entryCommentCount: json['entryCommentCount'] as int,
      postCount: json['postCount'] as int,
      postCommentCount: json['postCommentCount'] as int,
      isAdult: json['isAdult'] as bool,
    );

Map<String, dynamic> _$MagazineCollectionItemToJson(
        MagazineCollectionItem instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'user': instance.user,
      'cover': instance.image,
      'name': instance.name,
      'title': instance.title,
      'description': instance.description,
      'subscriptionsCount': instance.subscriptionsCount,
      'entryCount': instance.entryCount,
      'entryCommentCount': instance.entryCommentCount,
      'postCount': instance.postCount,
      'postCommentCount': instance.postCommentCount,
      'isAdult': instance.isAdult,
    };

MagazineCollectionItemUser _$MagazineCollectionItemUserFromJson(
        Map<String, dynamic> json) =>
    MagazineCollectionItemUser(
      apiUrl: json['@id'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$MagazineCollectionItemUserToJson(
        MagazineCollectionItemUser instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'username': instance.username,
    };

MagazineCollectionItemImage _$MagazineCollectionItemImageFromJson(
        Map<String, dynamic> json) =>
    MagazineCollectionItemImage(
      apiUrl: json['@id'] as String,
      filePath: json['filePath'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$MagazineCollectionItemImageToJson(
        MagazineCollectionItemImage instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'filePath': instance.filePath,
      'width': instance.width,
      'height': instance.height,
    };
