import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:provider/provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stats_provider.dart';

class ImmuneEffects extends StatelessWidget {
  const ImmuneEffects({Key? key}) : super(key: key);

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
