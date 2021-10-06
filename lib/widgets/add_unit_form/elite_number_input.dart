import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class EliteNumberInput extends StatelessWidget {
  final TextEditingController controller;
  final String maxValue;

  const EliteNumberInput({
    Key? key,
    required this.controller,
    required this.maxValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      child: CupertinoTextFormFieldRow(
        placeholder: 'Number of elite units',
        placeholderStyle: TextStyle(
          color: Color(0xFFD9D9D9),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            // return 'Please enter a number of elite units';
            value = '0';
          }

          if (int.parse(value) > int.parse(maxValue)) {
            return 'Value must not be bigger than $maxValue';
          }

          return null;
        },
      ),
      prefix: Text('Elites'),
    );
  }
}
