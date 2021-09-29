import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_comment_collection_model.dart';
import 'package:kbin_mobile/providers/api_provider.dart';

class CommentsRepository {
  Future<List<CommentCollectionItem>> fetchComments() async {
    Uri url = Uri.http(
        ApiProvider().getDomain(), 'api/entry_comments.jsonld');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      List<dynamic> entries = data["hydra:member"];

      return entries.map((json) => CommentCollectionItem.fromJson(json)).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }

  Future<List<EntryCommentsItem>> fetchEntryComments(int entryId) async {
    Uri url = Uri.http(
        ApiProvider().getDomain(), 'api/entries/$entryId/comments.jsonld');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      List<dynamic> entries = data["hydra:member"];

      return entries.map((json) => EntryCommentsItem.fromJson(json)).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }
}