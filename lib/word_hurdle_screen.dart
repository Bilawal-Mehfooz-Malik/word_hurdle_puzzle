import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle_puzzle/providers/hurdle_provider.dart';
import 'package:word_hurdle_puzzle/wordle_view.dart';

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
              child: Consumer<HurdleProvider>(
                builder: (context, value, child) => GridView.builder(
                  itemCount: value.hurdleBoard.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    final wordle = value.hurdleBoard[index];
                    return WordleView(wordle: wordle);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
