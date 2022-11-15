import 'package:flutter/material.dart';
import 'package:flutterboot/providers/items.dart';
import 'package:flutterboot/screens/ListScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Items(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter-Boot',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const ListScreen(),
      ),
    );
  }
}
