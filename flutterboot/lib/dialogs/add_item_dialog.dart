import 'package:flutter/material.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({Key? key}) : super(key: key);

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      title: const Text('Add Item'),
      content: TextField(
        autofocus: true,
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Item...'),
        onSubmitted: (value) => Navigator.pop(context, value),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
