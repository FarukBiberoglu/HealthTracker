import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled31/Porivder.dart';
import 'package:untitled31/idealMakroHesapla.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProivder(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: CalculatePage(),
    );
  }
}