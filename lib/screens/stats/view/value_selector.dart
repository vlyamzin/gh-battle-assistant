import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/common/direct_select/widget.dart';
import 'package:gh_battle_assistant/screens/stats/model/user_action.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';

class ValueSelector extends StatelessWidget {
  static final _countableValues =
      List.generate(10, (index) => index + 1, growable: false);
  static final _logicalValues = ['On', 'Off'];
  static final textStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Nyala',
  );
  const ValueSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UnitCubit>();

    return BlocBuilder<UnitCubit, UnitState>(
      buildWhen: (prev, cur) {
        return prev.userAction != cur.userAction;
      },
      builder: (context, state) {
        return state.when(ready: (unit, userAction) {
          return DirectSelect(
            child: SizedBox(
              height: 60,
              width: 60,
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Center(
                  child: _getValue(userAction.value),
                ),
              ),
            ),
            items: _initItems(userAction, context),
            onSelectedItemChanged: (i) {
              i = i ?? 0;
              if (UnitCubit.isCountableAction(userAction.actionType.type)) {
                cubit.selectActivityValue(_countableValues[i]);
              } else {
                cubit.selectActivityValue(i == 0);
              }
            },
            itemExtent: 35.0,
            selectedIndex: _getIndex(userAction.value),
          );
        });
      },
    );
  }

  List<Widget> _initItems(UserAction action, BuildContext context) {
    final widget = (dynamic value) {
      return SizedBox(
        height: 60,
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: FittedBox(
            child: Text(
              value.toString(),
              style: textStyle,
            ),
          ),
        ),
      );
    };

    if (UnitCubit.isCountableAction(action.actionType.type)) {
      return _countableValues.map((int value) {
        return widget(value);
      }).toList();
    } else {
      return _logicalValues.map((String value) => widget(value)).toList();
    }
  }

  Widget _getValue(dynamic value) {
    if (value is int) {
      return Text(value.toString());
    } else {
      return value
          ? Text(
              _logicalValues[0],
              style: textStyle,
            )
          : Text(
              _logicalValues[1],
              style: textStyle,
            );
    }
  }

  int _getIndex(dynamic value) {
    if (value is int) {
      return _countableValues.indexOf(value);
    } else {
      return value ? 0 : 1;
    }
  }
}
