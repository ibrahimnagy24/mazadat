import 'package:flutter/material.dart';

class PreviewAuctionController {
  PreviewAuctionController({required TickerProvider vsync})
      : _animationController = AnimationController(
          duration: const Duration(milliseconds: 300),
          vsync: vsync,
        );

  final AnimationController _animationController;

  AnimationController get animationController => _animationController;

  void dispose() {
    _animationController.dispose();
  }
}
