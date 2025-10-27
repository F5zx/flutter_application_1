import 'package:flutter/material.dart';
import 'screens/shopping_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dota 2 Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShoppingListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}