import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ButtonBar;
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/common/animated_flip_base.dart';
import 'package:gh_battle_assistant/controllers/unit_stats_provider.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/back_side.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/back_side_button.dart';
import 'package:gh_battle_assistant/widgets/unit_stats_card/stats_bar.dart';
import 'package:gh_battle_assistant/widgets/unit_stats_card/unit_portrait.dart';
import 'package:provider/provider.dart';

import 'active_effects.dart';
import 'immune_effects.dart';
import 'button_bar.dart';

class UnitStatsCard extends StatefulWidget {
  final double width, height;
  final UnitType type;
  final Unit unit;
  final VoidCallback onRemove;

  const UnitStatsCard({
    Key? key,
    required this.width,
    required this.height,
    required this.unit,
    required this.type,
    required this.onRemove,
  }) : super(key: key);

  @override
  _UnitStatsCardState createState() => _UnitStatsCardState();
}

class _UnitStatsCardState extends AnimatedFlipBaseState<UnitStatsCard> {
  @override
  Widget build(BuildContext context) {
    var controller = context.read<UnitStatsProvider>();

    return _unitDeadListener(
      child: AnimatedFlipCard(
        animation: super.animation,
        key: widget.key,
        frontSideChild: _body(),
        frontActionCallback: super.animationForward,
        backSideChild: UnitActionCardBackSide(
          title: '${widget.unit.displayName} ${widget.unit.number}',
          backButtonCallback: super.animationBackward,
          deleteButtonCallback: () => widget.onRemove(),
          buttons: [
            BackSideButton(
                action: () {
                  controller.endTurn();
                  super.animationBackward();
                },
                icon: Icons.check),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(ImageService.cardBackground),
      )),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: _leftSide()),
          Expanded(flex: 8, child: _rightSide()),
        ],
      ),
    );
  }

  Widget _leftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: UnitPortrait(
            unitNumber: widget.unit.number,
            type: widget.type,
            normality: (widget.unit.elite == true)
                ? UnitNormality.elite
                : UnitNormality.normal,
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              children: [
                ActiveEffects(),
                ImmuneEffects(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _rightSide() {
    return Column(
      children: [
        Expanded(child: StatsBar()),
        ButtonBar(),
      ],
    );
  }

  Widget _unitDeadListener({Widget? child}) {
    return Selector<UnitStatsProvider, bool>(
      builder: (_, shouldRemove, child) {
        if (shouldRemove) widget.onRemove();
        return child ?? Container();
      },
      selector: (_, controller) => controller.isUnitDead,
      child: child,
    );
  }
}
