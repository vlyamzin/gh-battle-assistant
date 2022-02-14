import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:provider/provider.dart';

class ActiveEffects extends StatelessWidget {
  const ActiveEffects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final negativeEffects = context.read<UnitCubit>().negativeEffects;

    return Container(
        padding: EdgeInsets.all(8.0),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          direction: Axis.horizontal,
          children: [
            Center(
              child: Text(
                'Active effects',
                softWrap: false,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Nyala',
                ),
              ),
            ),
            ...negativeEffects
                .map((Effect e) => EffectIcon(
                      key: ValueKey(e.type),
                      effect: e,
                    ))
                .toList(),
          ],
        ));
  }
}
