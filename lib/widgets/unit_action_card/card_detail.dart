import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/controllers/unit_action_provider.dart';
import 'package:gh_battle_assistant/models/unit_action.dart';
import 'package:provider/provider.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitActionProvider>(
      builder: (context, provider, child) {
        final action = provider.actions.currentAction;
        return Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Attack -1'),
                Text('Range -2'),
                Text('Range -2'),
                Text('Range -2'),
                Text('dasd asd asd asd a'),
                Text('Range -2'),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Builder(builder: (context) {
                  if (action != null && action.shouldRefresh == true) {
                    return Center(child: Icon(Icons.refresh));
                  } else {
                    return Container();
                  }
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
