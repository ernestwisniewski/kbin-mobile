import 'package:json_annotation/json_annotation.dart';

part 'entry_model.g.dart';

@JsonSerializable()
class Entry {
  final int id;
  final String title;
  final String? url;
  final String? body;
  final int comments;
  final int uv;
  final int dv;
  final bool isAdult;
  final String type;

  Entry(
      {required this.id,
      required this.title,
      this.url,
      this.body,
      required this.comments,
      required this.uv,
      required this.dv,
      required this.isAdult,
      required this.type});

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

  Map<String, dynamic> toJson() => _$EntryToJson(this);
}
