// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      id: json['id'] as int,
      apiUrl: json['@id'] as String,
      magazine:
          EntryMagazine.fromJson(json['magazine'] as Map<String, dynamic>),
      user: EntryUser.fromJson(json['user'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : EntryImage.fromJson(json['image'] as Map<String, dynamic>),
      title: json['title'] as String,
      url: json['url'] as String?,
      body: json['body'] as String?,
      comments: json['comments'] as int,
      uv: json['uv'] as int,
      dv: json['dv'] as int,
      isAdult: json['isAdult'] as bool,
      type: json['type'] as String,
    );

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'id': instance.id,
      '@id': instance.apiUrl,
      'magazine': instance.magazine,
      'user': instance.user,
      'image': instance.image,
      'title': instance.title,
      'url': instance.url,
      'body': instance.body,
      'comments': instance.comments,
      'uv': instance.uv,
      'dv': instance.dv,
      'isAdult': instance.isAdult,
      'type': instance.type,
    };

EntryMagazine _$EntryMagazineFromJson(Map<String, dynamic> json) =>
    EntryMagazine(
      apiUrl: json['@id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$EntryMagazineToJson(EntryMagazine instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'name': instance.name,
    };

EntryUser _$EntryUserFromJson(Map<String, dynamic> json) => EntryUser(
      apiUrl: json['@id'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$EntryUserToJson(EntryUser instance) => <String, dynamic>{
      '@id': instance.apiUrl,
      'username': instance.username,
    };

EntryImage _$EntryImageFromJson(Map<String, dynamic> json) => EntryImage(
      apiUrl: json['@id'] as String,
      filePath: json['filePath'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );

Map<String, dynamic> _$EntryImageToJson(EntryImage instance) =>
    <String, dynamic>{
      '@id': instance.apiUrl,
      'filePath': instance.filePath,
      'width': instance.width,
      'height': instance.height,
    };
