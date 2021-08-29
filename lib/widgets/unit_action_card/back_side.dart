import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/common/mixins/card_border_radius_mixin.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/back_side_button.dart';

class UnitActionCardBackSide extends StatelessWidget with CardBorderRadius {
  static const imagePath = 'assets/images/ability_back.jpg';
  final VoidCallback backButtonCallback, deleteButtonCallback;
  final String title;

  const UnitActionCardBackSide({
    Key? key,
    required this.backButtonCallback,
    required this.deleteButtonCallback,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Stack(
        children: [
          _backgroundImage(),
          _title(),
          _actionButtons(),
        ],
      ),
    );
  }

  Widget _backgroundImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(getRadius()),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }

  Widget _title() {
    return SizedBox.expand(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Builder(
            builder: (BuildContext context) {
              return Text(
                title,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(offset: Offset(1.5, 1.5), color: Color(0xFF333333))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _actionButtons() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BackSideButton(
              icon: Icons.arrow_back_rounded, action: backButtonCallback),
          BackSideButton(
              icon: Icons.delete_rounded, action: deleteButtonCallback),
        ],
      ),
    );
  }
}
