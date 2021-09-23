// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryCollectionItem _$EntryCollectionItemFromJson(Map<String, dynamic> json) =>
    EntryCollectionItem(
      id: json['id'] as int,
      apiUrl: json['@id'] as String,
      magazine: EntryCollectionItemMagazine.fromJson(
          json['magazine'] as Map<String, dynamic>),
      user: EntryCollectionItemUser.fromJson(
          json['user'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : EntryCollectionItemImage.fromJson(
              json['image'] as Map<String, dynamic>),
      domain: json['domain'] == null
          ? null
          : EntryCollectionItemDomain.fromJson(
              json['domain'] as Map<String, dynamic>),
      title: json['title'] as String,
      url: json['url'] as String?,
      body: json['body'] as String?,
      comments: json['comments'] as int,
      uv: json['uv'] as int,
      dv: json['dv'] as int,
      isAdult: json['isAdult'] as bool,
      type: json['type'] as String,
    );

Map<String, dynamic> _$EntryCollectionItemToJson(
        EntryCollectionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      '@id': instance.apiUrl,
      'magazine': instance.magazine,
      'user': instance.user,
      'image': instance.image,
      'domain': instance.domain,
      'title': instance.title,
      'url': instance.url,
      'body': instance.body,
      'comments': instance.comments,
      'uv': instance.uv,
      'dv': instance.dv,
      'isAdult': instance.isAdult,
      'type': instance.type,
    };

EntryCollectionItemMagazine _$EntryCollectionItemMagazineFromJson(
        Map<String, dynamic> json) =>
    EntryCollectionItemMagazine(
      apiUrl: json['@id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$EntryCollectionItemMagazineToJson(
        EntryCollectionItemMagazine instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'name': instance.name,
    };

EntryCollectionItemUser _$EntryCollectionItemUserFromJson(
        Map<String, dynamic> json) =>
    EntryCollectionItemUser(
      apiUrl: json['@id'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$EntryCollectionItemUserToJson(
        EntryCollectionItemUser instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'username': instance.username,
    };

EntryCollectionItemImage _$EntryCollectionItemImageFromJson(
        Map<String, dynamic> json) =>
    EntryCollectionItemImage(
      apiUrl: json['@id'] as String,
      filePath: json['filePath'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$EntryCollectionItemImageToJson(
        EntryCollectionItemImage instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'filePath': instance.filePath,
      'width': instance.width,
      'height': instance.height,
    };

EntryCollectionItemDomain _$EntryCollectionItemDomainFromJson(
        Map<String, dynamic> json) =>
    EntryCollectionItemDomain(
      apiUrl: json['@id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$EntryCollectionItemDomainToJson(
        EntryCollectionItemDomain instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'name': instance.name,
    };
