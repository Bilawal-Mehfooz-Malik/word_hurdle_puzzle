import 'package:flutter/material.dart';
import 'package:word_hurdle_puzzle/wordle_widget.dart';

class WordleView extends StatelessWidget {
  const WordleView({super.key, required this.wordle});

  final Wordle wordle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.amber, width: 1.5),
        color: wordle.existsInTarget
            ? Colors.white60
            : wordle.doesNotExistInTarget
                ? Colors.blueGrey.shade700
                : null,
      ),
      child: Text(
        wordle.letter,
        style: TextStyle(
          fontSize: 16,
          color: wordle.existsInTarget
              ? Colors.black
              : wordle.doesNotExistInTarget
                  ? Colors.white54
                  : Colors.white,
        ),
      ),
    );
  }
}
