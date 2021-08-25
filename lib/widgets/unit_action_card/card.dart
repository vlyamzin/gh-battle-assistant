import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/common/card_border_radius_mixin.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/back_side.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/card_detail.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/card_image.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/card_title.dart';
import 'package:provider/provider.dart';

class UnitActionCard extends StatefulWidget with CardBorderRadius {
  const UnitActionCard({Key? key, required this.width, required this.height, required this.monster})
      : super(key: key);

  final UnitStack monster;
  final double width, height;

  @override
  _UnitActionCardState createState() => _UnitActionCardState();
}

class _UnitActionCardState extends State<UnitActionCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addStatusListener((AnimationStatus status) {
        _animationStatus = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitStack>(
      builder: (context, model, _) {
        return AnimatedFlipCard(
          animation: _animation,
          frontActionCallback: () {
            if (_animationStatus == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          },
          frontSideChild: _body(),
          backSideChild: UnitActionCardBackSide(
            title: context.select<UnitStack, String>((value) => value.displayName),
            backButtonCallback: () => _animationController.reverse(),
            deleteButtonCallback: () {
              context.read<HomeScreenProvider>().removeMonsterStack(model.type);
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
    var type = context.read<UnitStack>().type;
    var imagePath = di<ImageService>().getUnitImageByType(type);

    return Expanded(
      flex: 1,
      child: CardImage(
        heightConstrain: widget.height,
        imagePath: imagePath
      ),
    );
  }

  /// Right side of the card
  Widget _rightSide() {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(),
          Flexible(
            flex: 1,
            child: CardDetail(),
          )
        ],
      ),
    );
  }
}
