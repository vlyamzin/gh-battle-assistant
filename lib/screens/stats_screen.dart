import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/widgets/unit_stats_card_list/unit_stats_card_list.dart';

class StatsScreen extends StatelessWidget {
  final UnitStack stack;
  final Map<UnitNormality, UnitRawStats> defaultStats;

  const StatsScreen({
    Key? key,
    required this.stack,
    required this.defaultStats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0xFF3C4659),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          stack.displayName,
          style: TextStyle(
            color: Color(0xFFC2ECF2),
            fontSize: 25,
            fontFamily: 'PirataOne',
            fontWeight: FontWeight.normal,
            letterSpacing: 2.5,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageService.mainBackground), fit: BoxFit.fill),
        ),
        child: UnitActionCardList(
          defaultStats: defaultStats,
          stack: stack,
        ),
      ),
    );
  }
}
