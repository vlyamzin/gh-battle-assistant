import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/common/animated_flip_base.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/back_side.dart';

class UnitStatsCard extends StatefulWidget {
  final double width, height;
  final Unit unit;

  const UnitStatsCard(
      {Key? key, required this.width, required this.height, required this.unit})
      : super(key: key);

  @override
  _UnitStatsCardState createState() => _UnitStatsCardState();
}

class _UnitStatsCardState extends AnimatedFlipBaseState<UnitStatsCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedFlipCard(
      animation: super.animation,
      key: widget.key,
      frontSideChild: Container(),
      frontActionCallback: super.animationForward,
      backSideChild: UnitActionCardBackSide(
        title: '${widget.unit.displayName} ${widget.unit.number}',
        backButtonCallback: super.animationBackward,
        deleteButtonCallback: () => print('Delete unit'),
      ),
    );
  }
}
