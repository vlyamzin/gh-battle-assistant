import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/common/animated_flip_base.dart';
import 'package:gh_battle_assistant/controllers/unit_stats_provider.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/unit.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/back_side.dart';
import 'package:provider/provider.dart';

import '../../di.dart';

class UnitStatsCard extends StatefulWidget {
  static const backgroundPath = 'assets/images/stats_front.jpg';
  final double width, height;
  final UnitType type;
  final Unit unit;

  const UnitStatsCard(
      {Key? key,
      required this.width,
      required this.height,
      required this.unit,
      required this.type})
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
      frontSideChild: _body(),
      frontActionCallback: super.animationForward,
      backSideChild: UnitActionCardBackSide(
        title: '${widget.unit.displayName} ${widget.unit.number}',
        backButtonCallback: super.animationBackward,
        deleteButtonCallback: () => print('Delete unit'),
      ),
    );
  }

  Widget _body() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(UnitStatsCard.backgroundPath),
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
      children: [
        _UnitPortrait(
          unitNumber: widget.unit.number!,
          type: widget.type,
          normality: (widget.unit.elite != null && widget.unit.elite == true)
              ? UnitNormality.elite
              : UnitNormality.normal,
        ),
        _ActiveEffects(),
      ],
    );
  }

  Widget _rightSide() {
    return Column(
      children: [
        Expanded(flex: 7, child: _StatsBar()),
        Expanded(flex: 3, child: _ButtonBar()),
        // Stats bar
        // Stats
        // Attack effects
        // Button bar
        // Buttons
      ],
    );
  }
}

class _UnitPortrait extends StatelessWidget {
  final int unitNumber;
  final UnitType type;
  final UnitNormality normality;

  const _UnitPortrait({
    Key? key,
    required this.unitNumber,
    required this.type,
    required this.normality,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            fit: BoxFit.contain,
            image: AssetImage(
                di<ImageService>().getUnitPortraitByType(type, normality)),
          ),
          Center(
            child: Text(
              unitNumber.toString(),
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'Nyala',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1.5, 1.5),
                    color: Color(0xFF333333),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveEffects extends StatelessWidget {
  const _ActiveEffects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF666666),
        ),
        child: Text('Active Effects'),
      ),
    );
  }
}

class _StatsBar extends StatelessWidget {
  const _StatsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: _Stats()),
        _AttackEffect(),
      ],
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final unit =
        context.select<UnitStatsProvider, Unit>((provider) => provider.unit);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(child: Text('Health: ${unit.healthPoint}')),
          Container(child: Text('Shield: ${unit.shield ?? '-'}')),
          Container(child: Text('Move: ${unit.move ?? '-'}')),
          Container(child: Text('Attack: ${unit.attack ?? '-'}')),
          Container(child: Text('Range: ${unit.range ?? '-'}')),
          Container(child: Text('Retaliate: ${unit.retaliate ?? '-'}')),
        ],
      ),
    );
  }
}

class _AttackEffect extends StatelessWidget {
  const _AttackEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF666666),
      ),
      child: Text('Attack Effects'),
    );
  }
}

class _ButtonBar extends StatelessWidget {
  const _ButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF741E1E),
            ),
            child: Text('Button bar'),
          ),
        )
      ],
    );
  }
}
