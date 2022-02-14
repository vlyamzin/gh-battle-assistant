import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ButtonBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/common/animated_flip_base.dart';
import 'package:gh_battle_assistant/common/unit_portrait.dart';
import 'package:gh_battle_assistant/common/enums/unit_normality.dart';
import 'package:gh_battle_assistant/common/enums/unit_type.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

class UnitStatsCard extends StatefulWidget {
  final double width, height;
  final UnitType type;

  const UnitStatsCard({
    Key? key,
    required this.width,
    required this.height,
    required this.type,
  }) : super(key: key);

  @override
  _UnitStatsCardState createState() => _UnitStatsCardState();
}

class _UnitStatsCardState extends AnimatedFlipBaseState<UnitStatsCard> {
  @override
  Widget build(BuildContext context) {
    final unit = context.read<UnitCubit>().unit;

    return AnimatedFlipCard(
      animation: super.animation,
      key: widget.key,
      frontSideChild: _body(),
      frontActionCallback: super.animationForward,
      backSideChild: UnitActionCardBackSide(
        title: '${unit.displayName} ${unit.number}',
        backButtonCallback: super.animationBackward,
        deleteButtonCallback: () =>
            context.read<StatsCubit>().unitRemoved(unit.number),
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
          child: BlocBuilder<UnitCubit, UnitState>(
            buildWhen: (prevState, state) {
              final prevUnit = prevState.unit;
              final unit = state.unit;

              return prevUnit.number != unit.number ||
                  prevUnit.elite != unit.elite;
            },
            builder: (context, state) {
              return UnitPortrait(
                unitNumber: state.unit.number,
                type: widget.type,
                normality: (state.unit.elite == true)
                    ? UnitNormality.elite
                    : UnitNormality.normal,
              );
            },
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
        Expanded(
          child: StatsBar(
            key: widget.key,
          ),
        ),
        ButtonBar(
          key: widget.key,
        ),
      ],
    );
  }
}
