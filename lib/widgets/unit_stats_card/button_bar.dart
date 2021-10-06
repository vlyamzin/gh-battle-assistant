import 'package:flutter/cupertino.dart';

import 'activity_button.dart';
import 'activity_selector.dart';

class ButtonBar extends StatelessWidget {
  const ButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        decoration: BoxDecoration(border: Border.all()),
        margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ActivitySelector(),
            Container(
              width: 1,
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(width: 1),
              )),
            ),
            ActivityButton(),
          ],
        ),
      ),
    );
  }
}