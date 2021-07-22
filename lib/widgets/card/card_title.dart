import 'package:flutter/widgets.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Text('Bandit Guard'),
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: Text(
              '99',
              style: TextStyle(fontSize: 15),
            ),
          ),
        )
        // SizedBox(child: Text('55'), width: 30, height: 30,)
      ],
    );
  }
}
