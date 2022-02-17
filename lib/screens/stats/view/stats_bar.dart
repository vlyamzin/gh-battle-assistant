import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/common/mixins/text_outline_mixin.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/common/enums/activity_type.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: _Stats(
            key: key,
          ),
        ),
        Flexible(
          flex: 1,
          child: AttackEffect(
            key: key,
          ),
        ),
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
      child: BlocBuilder<UnitCubit, UnitState>(
        buildWhen: (prevState, curState) {
          return prevState.unit != curState.unit;
        },
        builder: (context, state) {
          return state.when(ready: (unit, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _StatsRecord(
                  text:
                      'Health: ${unit.healthPoint > 0 ? unit.healthPoint : 0}',
                ),
                unit.isPierced
                    ? _StatsRecordWithIcon(
                        label: 'Shield: ',
                        iconPath: di<ImageService>().getAttackEffect(
                            IconSize.s32)[ActivityType.pierce]!,
                        value: unit.shield.toString(),
                      )
                    : _StatsRecord(text: 'Shield: ${unit.shield}'),
                unit.flying
                    ? _StatsRecordWithIcon(
                        label: 'Move: ',
                        iconPath: di<ImageService>().getIcon('fl'),
                        value: unit.move.toString())
                    : _StatsRecord(text: 'Move: ${unit.move ?? '0'}'),
                _StatsRecord(text: 'Attack: ${unit.attack ?? '0'}'),
                _StatsRecord(text: 'Range: ${unit.range ?? '0'}'),
                _StatsRecord(text: 'Retaliate: ${unit.retaliate}'),
              ],
            );
          });
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
