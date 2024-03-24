import 'package:flutter/material.dart';
import 'package:stock1/presentation/screens/main_route.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo.shade300,
        appBarTheme: const AppBarTheme(
          elevation:  10
        )
      ),
      home: const ProductList(),
    );
  }
}
