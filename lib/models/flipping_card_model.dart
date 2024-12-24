import 'package:flutter/material.dart';

enum FlippingCardStatus { open, closed }

class FlippingCardModel {
  final String imageUrl;
  FlippingCardStatus cardStatus = FlippingCardStatus.closed;
  AnimationController? controller;
  String? currentImageView;

  FlippingCardModel({required this.imageUrl});

  void initializeController(AnimationController controller) {
    this.controller = controller;
  }

  void reverseImage() {
    currentImageView = imageUrl;
  }

  void forwardImage() {
    currentImageView = null;
  }
}
