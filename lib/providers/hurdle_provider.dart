import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_hurdle_puzzle/wordle_widget.dart';
import 'package:english_words/english_words.dart' as words;

class HurdleProvider extends ChangeNotifier {
  String targetWord = '';
  List<String> rowInputs = [];
  List<String> totalWords = [];
  List<Wordle> hurdleBoard = [];
  final random = Random.secure();
  List<String> exculdedLetters = [];

  void init() {
    totalWords = words.all.where((element) => element.length == 5).toList();
    generateBoard();
    generateRandomWord();
  }

  void generateBoard() {
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ''));
  }

  void generateRandomWord() {
    targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
    debugPrint(targetWord);
  }
}
