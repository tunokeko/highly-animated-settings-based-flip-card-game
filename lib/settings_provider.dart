import 'package:flutter/material.dart';

enum Difficulty {
  easy(text: "Easy", numberOfCards: 3),
  medium(text: "Medium", numberOfCards: 6),
  hard(text: "Hard", numberOfCards: 9);

  final String text;
  final int numberOfCards;

  const Difficulty({required this.text, required this.numberOfCards});
}

class SettingsProvider extends ChangeNotifier {
  Difficulty difficulty = Difficulty.easy;

  void changeDifficulty(Difficulty difficulty) {
    this.difficulty = difficulty;
    notifyListeners();
  }
}
