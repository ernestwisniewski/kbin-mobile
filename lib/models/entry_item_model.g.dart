// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryItem _$EntryItemFromJson(Map<String, dynamic> json) => EntryItem(
      id: json['id'] as int,
      apiUrl: json['@id'] as String,
      magazine:
          EntryItemMagazine.fromJson(json['magazine'] as Map<String, dynamic>),
      user: EntryItemUser.fromJson(json['user'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : EntryItemImage.fromJson(json['image'] as Map<String, dynamic>),
      domain: json['domain'] == null
          ? null
          : EntryItemDomain.fromJson(json['domain'] as Map<String, dynamic>),
      title: json['title'] as String,
      url: json['url'] as String?,
      body: json['body'] as String?,
      comments: json['comments'] as int,
      uv: json['uv'] as int,
      dv: json['dv'] as int,
      isAdult: json['isAdult'] as bool,
      type: json['type'] as String,
      views: json['views'] as int,
      score: json['score'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActive: DateTime.parse(json['lastActive'] as String),
    );

Map<String, dynamic> _$EntryItemToJson(EntryItem instance) => <String, dynamic>{
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
      'views': instance.views,
      'score': instance.score,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastActive': instance.lastActive.toIso8601String(),
    };

EntryItemMagazine _$EntryItemMagazineFromJson(Map<String, dynamic> json) =>
    EntryItemMagazine(
      apiUrl: json['@id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$EntryItemMagazineToJson(EntryItemMagazine instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'name': instance.name,
    };

EntryItemUser _$EntryItemUserFromJson(Map<String, dynamic> json) =>
    EntryItemUser(
      apiUrl: json['@id'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] == null
          ? null
          : EntryItemImage.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EntryItemUserToJson(EntryItemUser instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'username': instance.username,
      'avatar': instance.avatar,
    };

EntryItemImage _$EntryItemImageFromJson(Map<String, dynamic> json) =>
    EntryItemImage(
      apiUrl: json['@id'] as String,
      filePath: json['filePath'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$EntryItemImageToJson(EntryItemImage instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'filePath': instance.filePath,
      'width': instance.width,
      'height': instance.height,
    };

EntryItemDomain _$EntryItemDomainFromJson(Map<String, dynamic> json) =>
    EntryItemDomain(
      apiUrl: json['@id'] as String,
      name: json['name'] as String,
      entryCount: json['entryCount'] as int,
    );

Map<String, dynamic> _$EntryItemDomainToJson(EntryItemDomain instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'name': instance.name,
      'entryCount': instance.entryCount,
    };
