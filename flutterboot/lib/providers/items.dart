// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterboot/models/item.dart';
import 'package:http/http.dart' as http;

class Items with ChangeNotifier {
  static const String serverUriPrefix = 'http://localhost:8080';

  Future<List<Item>> items() async {
    try {
      final response = await http.get(Uri.parse('$serverUriPrefix/api/items'));
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
              .map((j) => Item(j['id'], j['value']))
              .toList() ??
          [];
    } catch (exception) {
      print(exception);
      return [];
    }
  }

  Future<Item?> addItem(final String value) async {
    try {
      final response = await http.post(
        Uri.parse("$serverUriPrefix/api/items"),
        body: jsonEncode(Item.toJson(Item(null, value))),
        headers: {
          'Content-Type': 'application/json',
        },
        encoding: Encoding.getByName('utf-8'),
      );

      var jmap =
          (jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);

      notifyListeners();
      return Item.fromJson(jmap);
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<bool> removeItem(final String id) async {
    try {
      final response = await http.delete(Uri.parse(
        '$serverUriPrefix/api/items/$id',
      ));

      notifyListeners();
      return response.statusCode == 200;
    } catch (exception) {
      print(exception);
      return false;
    }
  }
}
