import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UnitNumberInput extends StatelessWidget {
  final TextEditingController controller;
  final String maxValue;

  const UnitNumberInput({Key? key, required this.controller, required this.maxValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      child: CupertinoTextFormFieldRow(
        placeholder: 'Number of units',
        controller: controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          // TODO add max limit of stack of selected unit type
          // if (value == null || value > getMaxNumber(_unitType.key))
          if (value == null || value.isEmpty) {
            return 'Please enter a number of units';
          }

          if (int.parse(value) > int.parse(maxValue)) {
            return 'Value must not be bigger than $maxValue';
          }

          return null;
        },
      ),
      prefix: Text('Units'),
    );
  }
}
