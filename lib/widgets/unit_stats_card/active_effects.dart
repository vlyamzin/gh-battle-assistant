import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/controllers/unit_stats_provider.dart';
import 'package:provider/provider.dart';

class ActiveEffects extends StatelessWidget {
  const ActiveEffects({Key? key}) : super(key: key);

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
