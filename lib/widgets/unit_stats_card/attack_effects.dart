import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/common/mixins/text_outline_mixin.dart';
import 'package:provider/provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stats_provider.dart';

class AttackEffect extends StatelessWidget with TextOutline {
  const AttackEffect({Key? key}) : super(key: key);

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
        .map((e) => Stack(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: e != null
                        ? Image(image: AssetImage(e.iconShortcut))
                        : Container(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: e != null && e.label != null
                      ? Text(
                          e.label!,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Nyala',
                              color: Color(0xFFE2461B),
                              shadows: outlinedText(
                                  strokeColor: Color(0xFFFFFFFF),
                                  strokeWidth: 1,
                                  precision: 1)),
                        )
                      : Container(),
                )
              ],
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
