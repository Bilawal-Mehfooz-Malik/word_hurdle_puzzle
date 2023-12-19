import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle_puzzle/data/error_message.dart';
import 'package:word_hurdle_puzzle/widgets/wordle_view_widget.dart';
import 'package:word_hurdle_puzzle/widgets/keyboard_view_widget.dart';
import 'package:word_hurdle_puzzle/providers/hurdle_provider.dart';

class WordHurdleScreen extends StatefulWidget {
  const WordHurdleScreen({super.key});

  @override
  State<WordHurdleScreen> createState() => _WordHurdleScreenState();
}

class _WordHurdleScreenState extends State<WordHurdleScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Word Hurdle')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Consumer<HurdleProvider>(
                  builder: (context, provider, child) => GridView.builder(
                    itemCount: provider.hurdleBoard.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      final wordle = provider.hurdleBoard[index];
                      return WordleView(wordle: wordle);
                    },
                  ),
                ),
              ),
            ),
            Consumer<HurdleProvider>(
              builder: (context, provider, child) => KeyboardView(
                excludedLetters: provider.exculdedLetters,
                onPressed: (value) {
                  provider.inputLetter(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer<HurdleProvider>(
                builder: (context, provider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: provider.deleteLetter,
                      child: const Text('DELETE'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!provider.isAValidWord) {
                          showErrorSnack(
                            context: context,
                            errorMessage: 'Not a word in my dictionary',
                          );
                          return;
                        }
                        if (provider.shouldCheckForAnswer) {
                          provider.checkAnswer();
                        }
                        if (provider.wins) {
                          showDialogs(
                            context: context,
                            title: 'You Win!!!',
                            body: 'The word was ${provider.targetWord}',
                            onPlayAgain: () {
                              Navigator.of(context).pop();
                              provider.resetGame();
                            },
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                          );
                        } else if (provider.noAttemptsLeft) {
                          showDialogs(
                            context: context,
                            title: 'You Lost!!!',
                            body: 'The word was ${provider.targetWord}',
                            onPlayAgain: () {
                              Navigator.of(context).pop();
                              provider.resetGame();
                            },
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                          );
                        }
                      },
                      child: const Text('SUBMIT'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
