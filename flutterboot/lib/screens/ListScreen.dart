import 'package:flutter/material.dart';
import 'package:flutterboot/dialogs/add_item_dialog.dart';
import 'package:flutterboot/providers/items.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemsProvider = context.watch<Items>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter-Boot'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.brown,
        child: FutureBuilder(
          future: itemsProvider.items(),
          builder: (ctx, snap) {
            final bool loaded = snap.connectionState == ConnectionState.done;
            final items = loaded ? snap.data! : [];

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (ctx, idx) {
                return Card(
                  elevation: 6,
                  color: Colors.orangeAccent,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(
                      items[idx].value ?? "<no-value>",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () => itemsProvider.removeItem(items[idx].id),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: ()=> showDialog(
            context: context,
            builder: (ctx) => const AddItemDialog(),
          ).then((value) {
            if (value != null) {
              itemsProvider.addItem(value);
            }
          }),
      ),
    );
  }
}
