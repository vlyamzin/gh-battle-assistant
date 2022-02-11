import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:provider/provider.dart';

class ImmuneEffects extends StatelessWidget {
  const ImmuneEffects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final immuneList = context.read<UnitCubit>().immuneEffects;

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
        .map((e) => EffectIcon(
              key: ValueKey(e?.type),
              effect: e,
            ))
        .toList();
  }
}
