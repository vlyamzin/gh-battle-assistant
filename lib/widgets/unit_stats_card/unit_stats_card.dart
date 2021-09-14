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
import 'package:simple_tooltip/simple_tooltip.dart';

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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _UnitPortrait(
          unitNumber: widget.unit.number!,
          type: widget.type,
          normality: (widget.unit.elite == true)
              ? UnitNormality.elite
              : UnitNormality.normal,
        ),
        Flexible(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Expanded(
              child: Column(
                children: [
                  _ActiveEffects(),
                  _ImmuneEffects(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rightSide() {
    return Column(
      children: [
        Expanded(flex: 7, child: _StatsBar()),
        Expanded(flex: 3, child: _ButtonBar()),
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
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Selector<UnitStatsProvider, Set<Effect>>(
          selector: (_, statsProvider) => statsProvider.activeEffects,
          shouldRebuild: (oldState, newState) =>
              oldState.length != newState.length,
          builder: (_, effects, __) => Wrap(
            alignment: WrapAlignment.spaceEvenly,
            direction: Axis.horizontal,
            children: [
              Center(
                child: Text(
                  'Active effects',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nyala',
                  ),
                ),
              ),
              ...effects
                  .map((Effect e) => SizedBox(
                        width: 40,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image(
                            image: AssetImage(e.iconShortcut),
                          ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ));
  }
}

class _ImmuneEffects extends StatelessWidget {
  const _ImmuneEffects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final immuneList = context.read<UnitStatsProvider>().immuneEffects;

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        direction: Axis.horizontal,
        children: [
          Center(
            child: Text(
              'Immune to',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Nyala',
              ),
            ),
          ),
          ..._list(immuneList),
        ],
      ),
    );
  }

  List<Widget> _list(List<Effect?> immuneList) {
    return immuneList
        .map((e) => SizedBox(
              width: 40,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: e != null
                    ? Image(image: AssetImage(e.iconShortcut))
                    : Container(),
              ),
            ))
        .toList();
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
    final unit = context.watch<UnitStatsProvider>().unit;

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
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _EndTurnButton(),
        Container(
          width: 50,
        ),
        _ActionButton(),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<UnitStatsProvider>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
          child: Icon(
            Icons.remove,
            size: 35,
            color: Color(0xFF000000),
          ),
          onPressed: () => provider.minusActivity(),
        ),
        _ActionTypeSelector(),
        CupertinoButton(
          child: Icon(
            Icons.add,
            size: 35,
            color: Color(0xFF000000),
          ),
          onPressed: () => provider.plusActivity(),
        ),
      ],
    );
  }
}

class _ActionTypeSelector extends StatefulWidget {
  const _ActionTypeSelector({Key? key}) : super(key: key);

  @override
  __ActionTypeSelectorState createState() => __ActionTypeSelectorState();
}

class __ActionTypeSelectorState extends State<_ActionTypeSelector> {
  late bool showTooltip;

  @override
  void initState() {
    super.initState();
    showTooltip = false;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTooltip(
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        onPressed: () => setState(() => showTooltip = !showTooltip),
        child: Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.all(6.5),
          child: Consumer<UnitStatsProvider>(
            builder: (context, provider, child) {
              return Image(
                image: AssetImage(
                  provider.selectedActivity.value,
                ),
              );
            },
          ),
        ),
      ),
      content: Row(
        children: context
            .read<UnitStatsProvider>()
            .getAvailableActivities
            .map(
              (activity) => GestureDetector(
                onTap: () {
                  Provider.of<UnitStatsProvider>(context, listen: false)
                      .selectedActivity = activity;
                  setState(() {
                    showTooltip = !showTooltip;
                  });
                },
                child: Image(
                  image: AssetImage(
                    activity.value,
                  ),
                ),
              ),
            )
            .toList(),
      ),
      arrowLength: 8,
      backgroundColor: Color(0xFF797979),
      borderColor: Color(0xFF696969),
      show: showTooltip,
    );
  }
}

class _EndTurnButton extends StatelessWidget {
  const _EndTurnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoButton(
        onPressed: () => print('End turn'),
        child: Container(
          child: Text(
            'End turn',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
          width: 70,
          padding: EdgeInsets.all(6.5),
          decoration: BoxDecoration(
            color: Color(0xFF9C0707),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
