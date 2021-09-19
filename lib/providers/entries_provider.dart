import 'dart:convert';

import 'package:kbin_mobile/models/entry_model.dart';
import 'package:http/http.dart' as http;
import 'package:kbin_mobile/providers/api_provider.dart';


class EntriesProvider {
  Future<List<Entry>> fetchEntries() async {
    Uri url = Uri.https(ApiProvider().getDomain(), 'api/entries.jsonld');

    var response = await http.get(url);

    if (response.statusCode == 200) {
     Map data = jsonDecode(response.body);

     List<dynamic> entries = data["hydra:member"];

     return entries.map((json) => Entry.fromJson(json)).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }

  Future<Entry> fetchEntry(int id) async {
    Uri url = Uri.https(ApiProvider().getDomain(), 'api/entries/$id.jsonld');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> entry = jsonDecode(response.body);

      return Entry.fromJson(entry);
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }
}
