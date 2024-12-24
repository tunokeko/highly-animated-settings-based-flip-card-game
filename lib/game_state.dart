import 'dart:math';

import 'package:animated_flip_card/models/flipping_card_model.dart';
import 'package:animated_flip_card/settings_provider.dart';
import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {
  static const List<String> images = [
    'assets/images/asteroid.png',
    'assets/images/astronaut.png',
    'assets/images/black_hole.png',
    'assets/images/comet.png',
    'assets/images/earth.png',
    'assets/images/moon.png',
    'assets/images/satellite.png',
    'assets/images/sun.png',
    'assets/images/universe.png',
  ];
  bool isAnimating = false;
  List<FlippingCardModel> gameShape = [];
  List<FlippingCardModel> candidateCards = [];
  Key key = UniqueKey();

  void initializeGameShape() {
    List<String> randomImages =
        getRandomElements<String>(images, difficulty.numberOfCards);
    List<String> collectionImages = [...randomImages, ...randomImages];
    print(difficulty);
    print(collectionImages);
    collectionImages.shuffle();
    gameShape = collectionImages.map((image) {
      return FlippingCardModel(imageUrl: image);
    }).toList();
  }

  List<T> getRandomElements<T>(List<T> list, int number) {
    List<T> randomList = [];
    while (randomList.length < number) {
      int randomInt = Random().nextInt(list.length);
      if (!randomList.contains(list[randomInt])) {
        randomList.add(list[randomInt]);
      }
    }

    return randomList;
  }

  final Difficulty difficulty;

  GameState({required this.difficulty}) {
    initializeGameShape();
  }

  void startAnimation() {
    if (isAnimating) return;
    isAnimating = true;
  }

  void stopAnimation() {
    if (!isAnimating) return;
    isAnimating = false;
  }

  void restart() {
    key = UniqueKey();
    initializeGameShape();
    isAnimating = false;
    candidateCards = [];
    notifyListeners();
  }

  void changeCardDirection(int index) async {
    if (gameShape[index].cardStatus == FlippingCardStatus.open) {
      return;
    }
    gameShape[index].cardStatus = FlippingCardStatus.open;
    await gameShape[index]
        .controller
        ?.forward(); //it waits until it fully goes to the upper bound
    candidateCards.add(gameShape[index]);

    if (candidateCards.length >= 2) {
      bool hasSameImage = candidateCards
          .every((card) => card.imageUrl == candidateCards[0].imageUrl);
      if (hasSameImage) {
        candidateCards = [];
        return;
      }

      for (final card in candidateCards) {
        card.cardStatus = FlippingCardStatus.closed;
        card.controller?.reverse();
      }
      candidateCards = [];
    }

    notifyListeners();
  }
}
