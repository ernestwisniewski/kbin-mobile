import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kbin_mobile/filters/stort_options_filters.dart';
import 'package:kbin_mobile/filters/time_options_filters.dart';
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_comment_collection_model.dart';
import 'package:kbin_mobile/repositories/api_provider.dart';

class CommentsRepository {
  Future<List<CommentCollectionItem>> fetchComments(
      int page,
      SortOptions sortOptions,
      TimeOptions timeOptions,
      String? pageView) async {
    String domain = await ApiProvider().getDomain();

    Map<String, dynamic>? filters = {
      'sort': sortOptions.toParam(),
      'time': timeOptions.toParam()
    };

    if (pageView != null) {
      filters['magazine'] = 'selfhosted';
    }

    Uri url = Uri.https(domain, 'api/entry_comments.jsonld', filters);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      List<dynamic> entries = data["hydra:member"];

      return entries
          .map((json) => CommentCollectionItem.fromJson(json))
          .toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }

  Future<List<EntryCommentsItem>> fetchEntryComments(int entryId) async {
    String domain = await ApiProvider().getDomain();
    Uri url = Uri.https(domain, 'api/entries/$entryId/comments.jsonld');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      List<dynamic> entries = data["hydra:member"];

      return entries.map((json) => EntryCommentsItem.fromJson(json)).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }
}
