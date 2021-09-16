import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/common/mixins/text_outline_mixin.dart';
import 'package:gh_battle_assistant/controllers/unit_action_provider.dart';
import 'package:provider/provider.dart';

class CardTitle extends StatelessWidget with TextOutline {
  final String title;
  const CardTitle({Key? key, required this.title}) : super(key: key);

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
              title,
              style: TextStyle(fontSize: 25, fontFamily: 'PirataOne'),
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
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'PirataOne',
                    shadows: outlinedText(
                      strokeColor: Color(0xFFFFFFFF),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
