import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/common/mixins/card_border_radius_mixin.dart';

class Card extends StatelessWidget with CardBorderRadius {
  const Card({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Color(0xFFC5C5C5),
          width: 1,
        ),
        borderRadius: BorderRadius.all(getRadius()),
        boxShadow: [
          BoxShadow(
              blurRadius: 3.5, spreadRadius: 0.5, color: Color(0xFF797979))
        ],
      ),
      child: child,
    );
  }
}
