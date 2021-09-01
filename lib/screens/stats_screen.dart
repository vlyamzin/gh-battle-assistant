import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';

class StatsScreen extends StatelessWidget {
  final UnitStack stack;
  static const backgroundImage = 'assets/images/ability_front_2.jpg';

  const StatsScreen({Key? key, required this.stack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'stats_${stack.type}',
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          leading: CupertinoNavigationBarBackButton(
            onPressed: () => Navigator.pop(context),
          ),
          middle: Text(
            stack.displayName,
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'PirataOne',
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.fill
            ),
          ),
          child: Center(
            child: Text(
              'Amazing things are going to be here!',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
