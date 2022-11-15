import 'package:quiver/core.dart';

class Item {
  String? id;
  String? value;

  Item([this.id, this.value]);

  @override
  bool operator ==(other) =>
      other is Item && id == other.id && value == other.value;

  @override
  int get hashCode => hash2(id.hashCode, value.hashCode);

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value'];

  static Map<String, dynamic> toJson(Item item) =>
      {'id': item.id, 'value': item.value};
}
