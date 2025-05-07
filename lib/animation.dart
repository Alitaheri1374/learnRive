import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimationRivWidget extends StatelessWidget {
  final void Function(Artboard)? onInit;
  const AnimationRivWidget({super.key,required this.onInit});

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/login_animation.riv',
      fit: BoxFit.cover,
      onInit: onInit,
    );
  }
}
