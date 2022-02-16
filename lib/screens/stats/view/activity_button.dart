import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';
import 'package:provider/provider.dart';

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
      child: withGestureDetector(
        action: () => cubit.applyUserAction(),
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text('Apply'),
          onPressed: () => cubit.applyUserAction(),
        ),
      ),
    );
  }
}
