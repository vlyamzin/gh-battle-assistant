import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/controllers/activity_tooltip_provider.dart';
import 'package:gh_battle_assistant/models/enums/activity_type.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:provider/provider.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class ActivityButton extends StatelessWidget {
  const ActivityButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UnitCubit>();

    var withGestureDetector = ({
      required Widget child,
      required Function action,
    }) {
      return GestureDetector(
        onDoubleTap: () => action(),
        child: child,
      );
    };

    return SizedBox(
      width: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            child: withGestureDetector(
              action: () => cubit.minusActivity(),
              child: CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Icon(
                  Icons.remove,
                  size: 35,
                  color: Color(0xFF000000),
                ),
                onPressed: () => cubit.minusActivity(),
              ),
            ),
          ),
          // Flexible(
          //   flex: 1,
          //   child: _Activity(
          //     child: GestureDetector(
          //       child: Container(
          //         padding: EdgeInsets.all(0),
          //         // child: Selector<UnitStatsProvider,
          //         //     MapEntry<ActivityType, String>>(
          //         //   builder: (_, activity, __) =>
          //         //       Image(image: AssetImage(activity.value)),
          //         //   selector: (_, provider) => provider.selectedActivity,
          //         // ),
          //       ),
          //       onTap: () => cubit.applyActivity(),
          //     ),
          //   ),
          // ),
          Flexible(
            flex: 1,
            child: withGestureDetector(
              action: () => cubit.plusActivity(),
              child: CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Icon(
                  Icons.add,
                  size: 35,
                  color: Color(0xFF000000),
                ),
                onPressed: () => cubit.plusActivity(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Activity extends StatelessWidget {
  const _Activity({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityTooltipProvider>(
      builder: (context, provider, child) => SimpleTooltip(
        child: child!,
        content: Text(
          provider.message,
          style: TextStyle(
              fontFamily: 'Nyala', fontSize: 28, color: Color(0xFFFFFFFF)),
        ),
        show: provider.showTooltip,
        arrowLength: 8,
        backgroundColor: Color(0xFF797979),
        borderColor: Color(0xFF696969),
      ),
      child: child,
    );
  }
}
