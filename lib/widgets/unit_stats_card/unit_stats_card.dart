import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/common/animated_flip_base.dart';
import 'package:gh_battle_assistant/common/mixins/text_outline_mixin.dart';
import 'package:gh_battle_assistant/controllers/activity_tooltip_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stats_provider.dart';
import 'package:gh_battle_assistant/models/enums/activity_type.dart';
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
        ),
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
            child: Column(
              children: [
                _ActiveEffects(),
                _ImmuneEffects(),
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
        Expanded(child: _StatsBar()),
        _ButtonBar(),
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
        Expanded(flex: 2, child: _Stats()),
        Flexible(flex: 1, child: _AttackEffect()),
      ],
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Consumer<UnitStatsProvider>(
        builder: (_, controller, __) {
          var unit = controller.unit;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _StatsRecord(
                text: 'Health: ${unit.healthPoint > 0 ? unit.healthPoint : 0}',
              ),
              controller.isPierced
                  ? _StatsRecordWithIcon(
                      label: 'Shield: ',
                      iconPath: di<ImageService>()
                          .getAttackEffect(IconSize.s32)[ActivityType.pierce]!,
                      value: unit.shield.toString(),
                    )
                  : _StatsRecord(text: 'Shield: ${unit.shield}'),
              _StatsRecord(text: 'Move: ${unit.move ?? '0'}'),
              _StatsRecord(text: 'Attack: ${unit.attack ?? '0'}'),
              _StatsRecord(text: 'Range: ${unit.range ?? '0'}'),
              _StatsRecord(text: 'Retaliate: ${unit.retaliate ?? '0'}'),
            ],
          );
        },
      ),
    );
  }
}

class _StatsRecord extends StatelessWidget with TextOutline {
  const _StatsRecord({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Nyala',
            fontSize: 22,
            shadows: outlinedText(
              strokeColor: Color(0xFFD0D0D0),
              strokeWidth: 1,
            )),
      ),
    );
  }
}

class _StatsRecordWithIcon extends StatelessWidget with TextOutline {
  const _StatsRecordWithIcon({
    Key? key,
    required this.label,
    required this.iconPath,
    required this.value,
  }) : super(key: key);

  final String label;
  final String iconPath;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontFamily: 'Nyala',
        fontSize: 22,
        shadows: outlinedText(
          strokeColor: Color(0xFFD0D0D0),
          strokeWidth: 1,
        ));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: textStyle,
        ),
        Container(
          width: 30,
          height: 30,
          child: Image(image: AssetImage(iconPath)),
        ),
        Text(
          value,
          style: textStyle,
        )
      ],
    );
  }
}

class _AttackEffect extends StatelessWidget {
  const _AttackEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<UnitStatsProvider>();
    final attackEffectList = controller.attackEffects;
    final areaEffectList = controller.areaEffects;

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        direction: Axis.horizontal,
        children: [
          Center(
            child: Text(
              'Attack effects',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Nyala',
              ),
            ),
          ),
          ..._attackList(attackEffectList),
          ..._areaList(areaEffectList),
        ],
      ),
    );
  }

  List<Widget> _attackList(List<Effect?> attackEffectList) {
    return attackEffectList
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

  List<Widget> _areaList(List<String> areaEffects) {
    return areaEffects
        .map((e) => Padding(
              padding: const EdgeInsets.all(2.0),
              child: e.isNotEmpty ? Image.asset(e) : Container(),
            ))
        .toList();
  }
}

class _ButtonBar extends StatelessWidget {
  const _ButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        decoration: BoxDecoration(border: Border.all()),
        margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ActivitySelector(),
            Container(
              width: 1,
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(width: 1),
              )),
            ),
            _ActionButton(),
          ],
        ),
      ),
    );
  }
}

class _ActivitySelector extends StatelessWidget {
  const _ActivitySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<UnitStatsProvider>();

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: provider.availableActivities
              .map(
                (activity) => GestureDetector(
                  onTap: () => provider.selectActivity(activity),
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(5),
                    child: Image(
                      image: AssetImage(
                        activity.value,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<UnitStatsProvider>();

    return SizedBox(
      width: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            child: CupertinoButton(
              padding: EdgeInsets.all(0),
              child: Icon(
                Icons.remove,
                size: 35,
                color: Color(0xFF000000),
              ),
              onPressed: () => provider.minusActivity(),
            ),
          ),
          Flexible(
            flex: 1,
            child: _ActivityButton(
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(0),
                  child: Selector<UnitStatsProvider,
                      MapEntry<ActivityType, String>>(
                    builder: (_, activity, __) =>
                        Image(image: AssetImage(activity.value)),
                    selector: (_, provider) => provider.selectedActivity,
                  ),
                ),
                onTap: () => provider.applyActivity(),
                onLongPress: () => print('LOng press'),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: CupertinoButton(
              padding: EdgeInsets.all(0),
              child: Icon(
                Icons.add,
                size: 35,
                color: Color(0xFF000000),
              ),
              onPressed: () => provider.plusActivity(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityButton extends StatelessWidget {
  const _ActivityButton({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityTooltipProvider>(
      builder: (context, provider, child) => SimpleTooltip(
        child: child!,
        content: Text(
          provider.message,
          style: TextStyle(
              fontFamily: 'Nyala', fontSize: 28, color: Color(0xFFFFFFFF)),
        ),
        show: provider.showTooltip,
        arrowLength: 8,
        backgroundColor: Color(0xFF797979),
        borderColor: Color(0xFF696969),
      ),
      child: child,
    );
  }
}
