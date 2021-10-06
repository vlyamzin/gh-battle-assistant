import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UnitNumberInput extends StatelessWidget {
  final TextEditingController controller;
  final int? maxValue;

  const UnitNumberInput({Key? key, required this.controller, required maxValue})
      : this.maxValue = maxValue ?? 6,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      child: CupertinoTextFormFieldRow(
        placeholder: 'Number of units',
        placeholderStyle: TextStyle(
          color: Color(0xFFD9D9D9),
        ),
        controller: controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a number of units';
          }

          if (int.parse(value) > maxValue!) {
            return 'Value must not be bigger than $maxValue';
          }

          return null;
        },
      ),
      prefix: Text('Units'),
    );
  }
}
