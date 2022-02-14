import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
