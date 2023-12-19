import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_hurdle_puzzle/data/wordle_data.dart';
import 'package:english_words/english_words.dart' as words;

class HurdleProvider extends ChangeNotifier {
  int index = 0;
  int count = 0;
  String targetWord = '';
  final lettersPerRow = 5;
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

  void inputLetter(String letter) {
    if (count < lettersPerRow) {
      count++;
      rowInputs.add(letter);
      hurdleBoard[index] = Wordle(letter: letter);
      index++;
      notifyListeners();
    }
  }

  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeAt(rowInputs.length - 1);
    }
    if (count > 0) {
      hurdleBoard[index - 1] = Wordle(letter: '');
      count--;
      index--;
    }
      notifyListeners();
  }
}
