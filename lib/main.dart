import 'package:flutter/material.dart';
import 'package:word_hurdle_puzzle/word_hurdle_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final _colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Colors.deepPurple);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'word hurdle puzzle',
      builder: EasyLoading.init(),
      home: const WordHurdleScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: _colorScheme),
    );
  }
}
