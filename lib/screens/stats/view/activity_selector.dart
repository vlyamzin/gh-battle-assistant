import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/common/direct_select/widget.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';

class ActivitySelector extends StatelessWidget {
  const ActivitySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UnitCubit>();
    final activityEffects = cubit.activityEffects;

    return BlocBuilder<UnitCubit, UnitState>(
      buildWhen: (prev, cur) {
        return prev.userAction != cur.userAction;
      },
      builder: (_, state) {
        return state.when(ready: (unit, userAction) {
          return DirectSelect(
            items: activityEffects
                .map(
                  (Effect e) => SizedBox(
                    height: 60,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Builder(builder: (context) {
                          return EffectIcon(
                            key: ValueKey(e.type),
                            effect: e,
                          );
                        }),
                      ),
                    ),
                  ),
                )
                .toList(),
            selectedIndex: userAction.actionType.id,
            onSelectedItemChanged: (i) {
              i = i ?? 0;
              cubit.selectActivityType(activityEffects[i]);
            },
            itemExtent: 50.0,
            height: 170,
            itemMagnification: 1.25,
            child: SizedBox(
              height: 60,
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: FittedBox(
                  child: Builder(builder: (context) {
                    return EffectIcon(
                      effect: state.userAction.actionType,
                    );
                  }),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
