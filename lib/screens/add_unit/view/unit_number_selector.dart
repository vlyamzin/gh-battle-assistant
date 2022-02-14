import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_battle_assistant/common/unit_portrait.dart';
import 'package:gh_battle_assistant/common/enums/unit_normality.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/screens/add_unit/add_unit.dart';

class UnitNumberSelector extends StatelessWidget {
  const UnitNumberSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUnitCubit, AddUnitState>(
      builder: (context, state) {
        if (state is UnitTypeSelectedS) {
          return GridView.count(
            crossAxisCount: 5,
            children: state.stack.availableNumbersPull.map((number) {
              var key = ValueKey(number.toString());
              return Padding(
                key: key,
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  key: key,
                  onTap: () => context.read<AddUnitCubit>().selectUnit(number),
                  child: _unitPortrait(state.stack, number),
                ),
              );
            }).toList(),
          );
        }

        return Container();
      },
    );
  }

  Widget _unitPortrait(UnitStack stack, int number) {
    var unit;

    try {
      unit = stack.getUnitByNumber(number);

      return UnitPortrait(
        unitNumber: number,
        type: stack.type,
        normality: stack.getUnitByNumber(number).elite
            ? UnitNormality.elite
            : UnitNormality.normal,
        greyOut: unit == null,
      );
    } catch (_) {
      return UnitPortrait(
        unitNumber: number,
        type: stack.type,
        normality: UnitNormality.normal,
        greyOut: true,
      );
    }
  }
}
