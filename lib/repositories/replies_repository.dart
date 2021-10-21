import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/repositories/api_provider.dart';

class RepliesRepository {
  Future<List<ReplyCollectionItem>> fetchPostReplies(int postId) async {
    String domain = await ApiProvider().getDomain();

    Uri url = Uri.https(domain, 'api/posts/$postId/comments.jsonld');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      List<dynamic> entries = data["hydra:member"];

      return entries.map((json) => ReplyCollectionItem.fromJson(json)).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }
}
