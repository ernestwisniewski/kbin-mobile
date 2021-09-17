import 'dart:convert';

import 'package:kbin_mobile/models/entry_model.dart';
import 'package:http/http.dart' as http;
import 'package:kbin_mobile/providers/api_provider.dart';


class EntriesProvider {
  Uri url = Uri.https(ApiProvider().getDomain(), 'api/entries.jsonld');

  Future<List<Entry>> fetchEntries() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
     Map data = jsonDecode(response.body);

     List<dynamic> entries = data["hydra:member"];

     return entries.map((json) => Entry.fromJson(json)).toList();
    }

    throw Exception("Something went wrong, ${response.statusCode}");
  }
}
