import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kbin_mobile/models/post_reply_collection_model.dart';
import 'package:kbin_mobile/providers/api_provider.dart';

class RepliesRepository {
  Future<List<PostReplyItem>> fetchPostReplies(int postId) async {
    Uri url = Uri.http(
        ApiProvider().getDomain(), 'api/posts/$postId/comments.jsonld');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      List<dynamic> entries = data["hydra:member"];

      return entries.map((json) => PostReplyItem.fromJson(json)).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }
}
