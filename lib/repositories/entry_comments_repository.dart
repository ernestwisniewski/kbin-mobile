import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kbin_mobile/models/entry_comments_model.dart';
import 'package:kbin_mobile/models/entry_item_model.dart';
import 'package:kbin_mobile/providers/api_provider.dart';


class EntryCommentsRepository {
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