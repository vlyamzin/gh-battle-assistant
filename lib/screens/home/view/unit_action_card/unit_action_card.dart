import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/common/back_side_button.dart';
import 'package:gh_battle_assistant/common/mixins/card_border_radius_mixin.dart';
import 'package:gh_battle_assistant/common/animated_flip_base.dart';
import 'package:gh_battle_assistant/common/mixins/text_outline_mixin.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:provider/provider.dart';

part 'back_side.dart';
part 'card_detail.dart';
part 'card_image.dart';
part 'card_title.dart';
part 'unit_action_record.dart';

class UnitActionCard extends StatefulWidget with CardBorderRadius {
  const UnitActionCard({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width, height;

  @override
  _UnitActionCardState createState() => _UnitActionCardState();
}

class _UnitActionCardState extends AnimatedFlipBaseState<UnitActionCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UnitStack>(
      builder: (context, stack, __) => AnimatedFlipCard(
        key: widget.key,
        animation: animation,
        frontActionCallback: animationForward,
        frontSideChild: _body(stack),
        backSideChild: UnitActionCardBackSide(
          title: stack.displayName,
          backButtonCallback: animationBackward,
          deleteButtonCallback: () {
            context.read<EnemiesBloc>().add(StackRemovedE(stack));
          },
        ),
      ),
    );
  }

  Widget _body(UnitStack stack) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_leftSide(stack.type), _rightSide(stack.displayName)],
    );
  }

  /// Left side of the card
  Widget _leftSide(UnitType type) {
    var imagePath = di<ImageService>().getUnitImageByType(type);

    return Expanded(
      flex: 1,
      child: CardImage(heightConstrain: widget.height, imagePath: imagePath),
    );
  }

  /// Right side of the card
  Widget _rightSide(String displayName) {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImageService.cardBackground),
          fit: BoxFit.fill,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTitle(
              title: displayName,
            ),
            Flexible(
              flex: 1,
              child: CardDetail(),
            )
          ],
        ),
      ),
    );
  }
}
