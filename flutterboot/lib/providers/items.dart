import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterboot/models/item.dart';
import 'package:http/http.dart' as http;

class Items with ChangeNotifier {
  static const String serverUriPrefix = 'http://localhost:8080';

  Future<List<Item>> items() async {
    try {
      final response = await http.get(Uri.parse('$serverUriPrefix/api/items'));

      final decodedResponse = jsonDecode(
        utf8.decode(response.bodyBytes),
      ) as List;

      return decodedResponse.map((j){
        return Item(j['id'], j['value']);
      }).toList() ?? [];

    } catch (exception) {
      print(exception);
      return [];
    }
  }

// FIXME: add item
// FIXME: remove item
}
