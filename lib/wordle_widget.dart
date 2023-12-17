class Wordle {
  Wordle({
    required this.letter,
    this.existsInTarget = false,
    this.doesNotExistInTarget = false,
  });

  String letter;
  bool existsInTarget;
  bool doesNotExistInTarget;
}
