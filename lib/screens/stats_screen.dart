import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/common/grid.dart';
import 'package:gh_battle_assistant/controllers/unit_stats_provider.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/widgets/unit_stats_card/unit_stats_card.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatefulWidget {
  final UnitStack stack;
  static const backgroundImage = 'assets/images/ability_front_2.jpg';

  const StatsScreen({Key? key, required this.stack}) : super(key: key);

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
    return Hero(
      tag: 'stats_${widget.stack.type}',
      child: CupertinoPageScaffold(
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
                  _fadeAnimationController.forward();
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Grid(
                      landscape: 2,
                      portrait: 1,
                      childWidth: 1.8,
                      childHeight: 1,
                      children: _unitCards(),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )),
      ),
    );
  }

  List<Widget> _unitCards() {
    return widget.stack.units.map((unit) {
      return ChangeNotifierProvider(
        create: (BuildContext context) => UnitStatsProvider(unit: unit),
        child: UnitStatsCard(
          key: ValueKey(unit.number),
          width: 500,
          height: 400,
          unit: unit,
          type: widget.stack.type,
        ),
      );
    }).toList();
  }
}
