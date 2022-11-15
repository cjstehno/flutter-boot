import 'dart:convert';

import 'package:flutterboot/models/item.dart';
import 'package:test/test.dart';

void main() {
  test('Item should serialize to JSON', () {
    final json = jsonEncode(Item.toJson(Item('some_id', 'some_value')));
    expect(json, '{"id":"some_id","value":"some_value"}');
  });

  test('Item should deserialize from JSON', () {
    final item = Item.fromJson(jsonDecode('{"id":"some_id","value":"some_value"}'));
    expect(Item('some_id', 'some_value'), item);
  });
}
