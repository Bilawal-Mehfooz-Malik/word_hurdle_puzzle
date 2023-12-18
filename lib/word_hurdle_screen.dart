import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle_puzzle/keyboard_view.dart';
import 'package:word_hurdle_puzzle/wordle_view.dart';
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
            const KeyboardView(),
          ],
        ),
      ),
    );
  }
}
