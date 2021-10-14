import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kbin_mobile/filters/stort_options_filters.dart';
import 'package:kbin_mobile/filters/time_options_filters.dart';
import 'package:kbin_mobile/models/post_collection_model.dart';
import 'package:kbin_mobile/models/post_item_model.dart';
import 'package:kbin_mobile/repositories/api_provider.dart';

class PostsRepository {
  Future<List<PostCollectionItem>> fetchPosts(int page, SortOptions sortOptions, TimeOptions timeOptions) async {
    Uri url = Uri.http(ApiProvider().getDomain(), 'api/posts.jsonld', {'sort': sortOptions.toParam(), 'time': timeOptions.toParam()});

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      List<dynamic> posts = data["hydra:member"];

      return posts.map((json) => PostCollectionItem.fromJson(json)).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }

  Future<PostItem> fetchPost(int id) async {
    Uri url = Uri.https(ApiProvider().getDomain(), 'api/posts/$id.jsonld');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> entry = jsonDecode(response.body);

      return PostItem.fromJson(entry);
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }
}
