import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/animation/animated_flip_card.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/back/unit_raw_actions.dart';
import 'package:gh_battle_assistant/common/mixins/card_border_radius_mixin.dart';
import 'package:gh_battle_assistant/controllers/home_screen_provider.dart';
import 'package:gh_battle_assistant/controllers/unit_action_provider.dart';
import 'package:gh_battle_assistant/di.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/services/image_service.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/back_side.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/card_detail.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/card_image.dart';
import 'package:gh_battle_assistant/widgets/unit_action_card/card_title.dart';
import 'package:provider/provider.dart';

class UnitActionCard extends StatefulWidget with CardBorderRadius {
  const UnitActionCard(
      {Key? key,
      required this.width,
      required this.height,
      required this.stack})
      : super(key: key);

  final backgroundImage = 'assets/images/ability_front_2.jpg';
  final UnitStack stack;
  final double width, height;

  @override
  _UnitActionCardState createState() => _UnitActionCardState();
}

class _UnitActionCardState extends State<UnitActionCard>
    with SingleTickerProviderStateMixin {
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
    return AnimatedFlipCard(
      animation: _animation,
      frontActionCallback: () {
        if (_animationStatus == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      },
      frontSideChild: _body(),
      backSideChild: UnitActionCardBackSide(
        title: widget.stack.displayName,
        backButtonCallback: () => _animationController.reverse(),
        deleteButtonCallback: () {
          context.read<HomeScreenProvider>().removeMonsterStack(widget.stack.type);
        },
      ),
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
    var type = widget.stack.type;
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
      child: ChangeNotifierProvider<UnitActionProvider>(
        create: (context) {
          final UnitStack stack = widget.stack;
          final HomeScreenProvider store = context.read<HomeScreenProvider>();
          final List<UnitRawAction> rawData =
              context.read<GameData>().getUnitDataById(stack.type).actions;

          return UnitActionProvider(
              actions: stack.actions, store: store, rawData: rawData);
        },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(widget.backgroundImage),
            fit: BoxFit.fill,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(title: widget.stack.displayName,),
              Flexible(
                flex: 1,
                child: CardDetail(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
