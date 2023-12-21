import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:word_hurdle_puzzle/providers/hurdle_provider.dart';
import 'package:word_hurdle_puzzle/screens/word_hurdle_screen.dart';

final _colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Colors.deepPurple);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HurdleProvider(),
      child: const MyApp(),
    ),
  );
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
