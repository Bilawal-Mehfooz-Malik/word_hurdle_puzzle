import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_hurdle_puzzle/data/wordle_data.dart';
import 'package:english_words/english_words.dart' as words;

class HurdleProvider extends ChangeNotifier {
  int index = 0;
  int count = 0;
  int attempts = 0;
  bool wins = false;
  String targetWord = '';
  final totalAttempts = 6;
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

  bool get isAValidWord => totalWords.contains(
        rowInputs.join('').toLowerCase(),
      );
  bool get shouldCheckForAnswer => rowInputs.length == lettersPerRow;

  void checkAnswer() {
    final input = rowInputs.join('');
    if (targetWord == input) {
      wins = true;
    } else {
      _markLetterOnBoard();
      if (attempts < totalAttempts) {
        _gotToNextRow();
      }
    }
  }

  void _markLetterOnBoard() {
    for (int i = 0; i < hurdleBoard.length; i++) {
      if (hurdleBoard[i].letter.isNotEmpty &&
          targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].existsInTarget = true;
      } else if (hurdleBoard[i].letter.isNotEmpty &&
          !targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].doesNotExistInTarget = true;
        exculdedLetters.add(hurdleBoard[i].letter);
      }
    }
    notifyListeners();
  }

  void _gotToNextRow() {
    attempts++;
    count = 0;
    rowInputs.clear();
  }

  bool get noAttemptsLeft => attempts == totalAttempts;

  void resetGame() {
    count = 0;
    index = 0;
    rowInputs.clear();
    hurdleBoard.clear();
    exculdedLetters.clear();
    attempts = 0;
    wins = false;
    targetWord = '';
    generateBoard();
    generateRandomWord();
    debugPrint(count.toString());
    debugPrint(index.toString());
    notifyListeners();
  }
}
