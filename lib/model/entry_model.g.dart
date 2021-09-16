// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      id: json['id'] as int,
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
      'title': instance.title,
      'url': instance.url,
      'body': instance.body,
      'comments': instance.comments,
      'uv': instance.uv,
      'dv': instance.dv,
      'isAdult': instance.isAdult,
      'type': instance.type,
    };
