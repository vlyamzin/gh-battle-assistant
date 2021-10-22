import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/common/mixins/card_border_radius_mixin.dart';
import 'package:gh_battle_assistant/common/animated_flip_base.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/screens/home/home.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/back_side.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/card_detail.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/card_image.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/card_title.dart';
import 'package:provider/provider.dart';

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
