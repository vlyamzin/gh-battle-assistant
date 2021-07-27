import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/home_screen_model.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:provider/provider.dart';

class AddUnitScreen extends StatelessWidget {
  const AddUnitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _navBar(context),
      child: ListView(
        children: [
          Text('test'),
          CupertinoButton(
            child: Text('add unit'),
            onPressed: () {
              di<HomeScreenModel>()
                ..addMonsterStack(
                  UnitStack(id: '888', type: UnitType.banditGuard),
                );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  CupertinoNavigationBar _navBar(BuildContext context) {
    return CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text('Add Unit'));
  }
}
