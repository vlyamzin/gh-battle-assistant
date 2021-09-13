import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/controllers/unit_action_provider.dart';
import 'package:gh_battle_assistant/widgets/unit_action_record/unit_action_record.dart';
import 'package:provider/provider.dart';

class CardDetail extends StatelessWidget {
  static const iconPath = 'assets/images/icons/';
  const CardDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitActionProvider>(
      builder: (context, provider, child) {
        final action = provider.actions.currentAction;
        return Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: action != null
                    ? action.values
                        .map((e) => UnitActionRecord(record: e))
                        .toList()
                    : [Container()],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: SizedBox(
                width: 25,
                height: 25,
                child: Builder(builder: (context) {
                  if (action != null && action.shouldRefresh == true) {
                    return Center(
                        child: Image(
                      image: AssetImage('${iconPath}64/refresh_64.png'),
                    ));
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
