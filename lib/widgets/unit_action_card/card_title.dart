import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/controllers/unit_action_provider.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:provider/provider.dart';

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
            child: Text(
              context.select<UnitStack, String>((unit) => unit.displayName),
            ),
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: Consumer<UnitActionProvider>(
              builder: (context, provider, _) {
                final action = provider.actions.currentAction ?? null;
                return Text(
                  action != null ? action.initiative.toString() : '',
                  style: TextStyle(fontSize: 17),
                );
              },
            ),
          ),
        )
        // SizedBox(child: Text('55'), width: 30, height: 30,)
      ],
    );
  }
}
