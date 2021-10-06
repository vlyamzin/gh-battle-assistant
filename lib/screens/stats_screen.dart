import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/back/unit_raw_stats.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/widgets/unit_stats_card_list/unit_stats_card_list.dart';

class StatsScreen extends StatefulWidget {
  final UnitStack stack;
  final Map<UnitNormality, UnitRawStats> defaultStats;
  static const backgroundImage = 'assets/images/ability_front_2.jpg';

  const StatsScreen({
    Key? key,
    required this.stack,
    required this.defaultStats,
  }) : super(key: key);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    _fadeAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(_fadeAnimationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          widget.stack.displayName,
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'PirataOne',
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(StatsScreen.backgroundImage),
                fit: BoxFit.fill),
          ),
          child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 300)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // _fadeAnimationController.forward();
                return UnitActionCardList(
                  defaultStats: widget.defaultStats,
                  stack: widget.stack,
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
