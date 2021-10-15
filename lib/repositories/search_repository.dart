import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kbin_mobile/models/comment_collection_model.dart';
import 'package:kbin_mobile/models/entry_collection_model.dart';
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/repositories/api_provider.dart';

class SearchRepository {
  Future<List<dynamic>> search(String query) async {
    Uri url = Uri.http(ApiProvider().getDomain(), 'api/searches.jsonld', {'q': query});

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      List<dynamic> subjects = data["hydra:member"];

      return subjects.map((subject) {
        switch (subject['@type']) {
          case 'entry':
            return EntryCollectionItem.fromJson(subject);
          case 'entry_comment':
            return CommentCollectionItem.fromJson(subject);
          case 'post':
            return PostCollectionItem.fromJson(subject);
          case 'post_comment':
            return ReplyCollectionItem.fromJson(subject);
          case 'magazine':
            return MagazineCollectionItem.fromJson(subject);
        }
      }).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }
}
