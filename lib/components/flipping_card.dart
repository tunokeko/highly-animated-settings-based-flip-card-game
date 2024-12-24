import 'dart:math';

import 'package:animated_flip_card/game_state.dart';
import 'package:animated_flip_card/models/flipping_card_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlippingCard extends StatefulWidget {
  const FlippingCard(
      {super.key, required this.flippingCardModel, required this.index});
  final FlippingCardModel flippingCardModel;
  final int index;

  @override
  State<FlippingCard> createState() => _FlippingCardState();
}

class _FlippingCardState extends State<FlippingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    Tween<double> rotationTween = Tween<double>(begin: 0, end: 180);
    _animation = rotationTween.animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.flippingCardModel.initializeController(_controller);
      _controller.addStatusListener((AnimationStatus status) {
        final gameState = context.read<GameState>();
        if (gameState.isAnimating &&
            (status == AnimationStatus.completed ||
                status == AnimationStatus.dismissed)) {
          context.read<GameState>().stopAnimation();
        }
      });

      _animation.addListener(() {
        setState(() {
          if (_animation.value >= 90 && _animation.value <= 180) {
            context.read<GameState>().gameShape[widget.index].reverseImage();
          } else {
            context.read<GameState>().gameShape[widget.index].forwardImage();
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void reverseShape() {
    final gameState = Provider.of<GameState>(context, listen: false);
    if (gameState.isAnimating) {
      return;
    }
    context.read<GameState>().startAnimation();
    gameState.changeCardDirection(widget.index);
  }

  double degreeToRadian(double degree) => pi / 180 * degree;

  @override
  Widget build(BuildContext context) {
    //if it is between 90 and 270 i will change the currentImage and gameShape
    final currentImage = widget.flippingCardModel.currentImageView;
    return GestureDetector(
      onTap: reverseShape,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey,
            child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(degreeToRadian(_animation.value)),
                alignment: Alignment.center,
                child: currentImage != null
                    ? Transform(
                        transform: Matrix4.identity()..rotateY(pi),
                        alignment: Alignment.center,
                        child: Image.asset(currentImage),
                      )
                    : Image.asset(
                        'assets/images/question.png',
                        colorBlendMode: BlendMode.multiply,
                        color: Colors.grey,
                      )),
          );
        },
      ),
    );
  }
}
