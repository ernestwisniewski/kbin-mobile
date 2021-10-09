import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kbin_mobile/models/magazine_collection_model.dart';
import 'package:kbin_mobile/repositories/api_provider.dart';

class MagazinesRepository {
  Future<List<MagazineCollectionItem>> fetchMagazines() async {
    Uri url = Uri.http(
        ApiProvider().getDomain(), 'api/magazines.jsonld');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      List<dynamic> magazines = data["hydra:member"];

      return magazines.map((json) => MagazineCollectionItem.fromJson(json)).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }
}
