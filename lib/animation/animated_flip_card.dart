import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/common/card.dart';
import 'package:gh_battle_assistant/common/mixins/card_border_radius_mixin.dart';

class AnimatedFlipCard extends AnimatedWidget with CardBorderRadius {
  AnimatedFlipCard({
    Key? key,
    required Animation<double> this.animation,
    this.frontActionCallback,
    this.frontSideChild,
    this.backSideChild,
  }) : super(key: key, listenable: animation);

  final animation;
  final VoidCallback? frontActionCallback;
  final Widget? frontSideChild;
  final Widget? backSideChild;

  @override
  Widget build(BuildContext context) {
    return _transformation(
      child: Card(child: _getCorrectSide()),
    );
  }

  Widget _transformation({required Widget child}) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi * animation.value),
      child: child,
    );
  }

  Widget _userEvent({required Widget child}) {
    return GestureDetector(
      child: child,
      behavior: HitTestBehavior.opaque,
      onLongPress: frontActionCallback,
    );
  }

  Widget _getCorrectSide() {
    var fChild = frontSideChild ?? Container(child: Text('No Front Widget'));
    var bChild = backSideChild ?? _noBackWidgetPlaceholder();

    fChild = _userEvent(child: fChild);

    return animation.value <= 0.5 ? fChild : bChild;
  }

  Widget _noBackWidgetPlaceholder() {
    return Transform(
      transform: Matrix4.identity()..rotateY(pi),
      alignment: Alignment.center,
      child: Container(child: Text('No Back Widget')),
    );
  }
}
