import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/controllers/unit_action_provider.dart';
import 'package:provider/provider.dart';

class CardTitle extends StatelessWidget {
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
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'PirataOne'
              ),
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
                  style: TextStyle(fontSize: 25, fontFamily: 'PirataOne', shadows: _outlinedText(strokeColor: Color(0xFFFFFFFF))),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Outlines a text using shadows.
  static List<Shadow> _outlinedText({double strokeWidth = 2, Color strokeColor = Colors.black, int precision = 5}) {
    Set<Shadow> result = HashSet();
    for (int x = 1; x < strokeWidth + precision; x++) {
      for(int y = 1; y < strokeWidth + precision; y++) {
        double offsetX = x.toDouble();
        double offsetY = y.toDouble();
        result.add(Shadow(offset: Offset(-strokeWidth / offsetX, -strokeWidth / offsetY), color: strokeColor));
        result.add(Shadow(offset: Offset(-strokeWidth / offsetX, strokeWidth / offsetY), color: strokeColor));
        result.add(Shadow(offset: Offset(strokeWidth / offsetX, -strokeWidth / offsetY), color: strokeColor));
        result.add(Shadow(offset: Offset(strokeWidth / offsetX, strokeWidth / offsetY), color: strokeColor));
      }
    }
    return result.toList();
  }
}
