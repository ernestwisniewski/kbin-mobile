import 'dart:convert';

import 'package:kbin_mobile/model/entry_model.dart';
import 'package:http/http.dart' as http;


class EntriesProvider {
  Uri url = Uri.https('dev.karab.in', 'api/entries.jsonld');

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
