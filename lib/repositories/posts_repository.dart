import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/providers/api_provider.dart';

class PostsRepository {
  Future<List<PostCollectionItem>> fetchPosts() async {
    Uri url = Uri.http(ApiProvider().getDomain(), 'api/posts.jsonld');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      List<dynamic> posts = data["hydra:member"];

      return posts.map((json) => PostCollectionItem.fromJson(json)).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }
}
