import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ButtonBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/common/animated_flip_base.dart';
import 'package:gh_battle_assistant/common/unit_portrait.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

import 'active_effects.dart';
import 'immune_effects.dart';
import 'button_bar.dart';

class UnitStatsCard extends StatefulWidget {
  final double width, height;
  final UnitType type;
  final VoidCallback onRemove;

  const UnitStatsCard({
    Key? key,
    required this.width,
    required this.height,
    required this.type,
    required this.onRemove,
  }) : super(key: key);

  @override
  _UnitStatsCardState createState() => _UnitStatsCardState();
}

class _UnitStatsCardState extends AnimatedFlipBaseState<UnitStatsCard> {
  @override
  Widget build(BuildContext context) {
    // var controller = context.read<UnitStatsProvider>();

    return AnimatedFlipCard(
      animation: super.animation,
      key: widget.key,
      frontSideChild: _body(),
      frontActionCallback: super.animationForward,
      // TODO add backside widget
      // backSideChild: UnitActionCardBackSide(
      //   title: '${widget.unit.displayName} ${widget.unit.number}',
      //   backButtonCallback: super.animationBackward,
      //   deleteButtonCallback: () => widget.onRemove(),
      //   buttons: [
      //     BackSideButton(
      //         action: () {
      //           controller.endTurn();
      //           super.animationBackward();
      //         },
      //         icon: Icons.check),
      //   ],
      // ),
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
          child: BlocBuilder<UnitCubit, UnitState>(
            builder: (context, state) {
              return state.when(ready: (unit) {
                return UnitPortrait(
                  unitNumber: unit.number,
                  type: widget.type,
                  normality: (unit.elite == true)
                      ? UnitNormality.elite
                      : UnitNormality.normal,
                );
              });
            },
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              children: [
                // ActiveEffects(),
                // ImmuneEffects(),
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
        Expanded(
            child: StatsBar(
          key: widget.key,
        )),
        ButtonBar(
          key: widget.key,
        ),
      ],
    );
  }

  // Widget _unitDeadListener({Widget? child}) {
  //   return Selector<UnitStatsProvider, bool>(
  //     builder: (_, shouldRemove, child) {
  //       if (shouldRemove) widget.onRemove();
  //       return child ?? Container();
  //     },
  //     selector: (_, controller) => controller.isUnitDead,
  //     child: child,
  //   );
  // }
}
