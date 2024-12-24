import 'package:animated_flip_card/components/flipping_card.dart';
import 'package:animated_flip_card/game_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardTable extends StatelessWidget {
  const CardTable({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics:
          NeverScrollableScrollPhysics(), // To prevent conflicting scrolling behaviour between this and singlechildscrollview
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      childAspectRatio: 0.75,
      children: List.generate(gameState.gameShape.length, (index) {
        return FlippingCard(
          flippingCardModel: gameState.gameShape[index],
          index: index,
        );
      }),
    );
  }
}
