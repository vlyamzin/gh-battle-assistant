import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/common/mixins/card_border_radius_mixin.dart';
import 'package:gh_battle_assistant/common/animated_flip_base.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_stack_provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
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

  final backgroundImage = 'assets/images/ability_front_2.jpg';
  final double width, height;

  @override
  _UnitActionCardState createState() => _UnitActionCardState();
}

class _UnitActionCardState extends AnimatedFlipBaseState<UnitActionCard> {
  late UnitStack stack;

  @override
  Widget build(BuildContext context) {
    stack = context.watch<UnitStackProvider>().unitStack;

    return AnimatedFlipCard(
      animation: animation,
      frontActionCallback: animationForward,
      frontSideChild: _body(),
      backSideChild: UnitActionCardBackSide(
        title: stack.displayName,
        backButtonCallback: animationBackward,
        deleteButtonCallback: () {
          context.read<HomeScreenProvider>().removeMonsterStack(stack.type);
        },
      ),
    );
  }

  Widget _body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_leftSide(), _rightSide()],
    );
  }

  /// Left side of the card
  Widget _leftSide() {
    var type = stack.type;
    var imagePath = di<ImageService>().getUnitImageByType(type);

    return Expanded(
      flex: 1,
      child: CardImage(heightConstrain: widget.height, imagePath: imagePath),
    );
  }

  /// Right side of the card
  Widget _rightSide() {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(widget.backgroundImage),
          fit: BoxFit.fill,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTitle(
              title: stack.displayName,
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
