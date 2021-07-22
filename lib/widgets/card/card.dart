import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/widgets/card/card_border_radius_mixin.dart';
import 'package:gh_battle_assistant/widgets/card/card_detail.dart';
import 'package:gh_battle_assistant/widgets/card/card_image.dart';
import 'package:gh_battle_assistant/widgets/card/card_title.dart';

class Card extends StatefulWidget with CardBorderRadius {
  const Card({Key? key, required this.width, required this.height})
      : super(key: key);

  final double width, height;

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        _animationStatus = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return _transformation(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              color: Color(0xFFC5C5C5),
              width: 1,
            ),
            borderRadius: BorderRadius.all(widget.getRadius()),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3.0, spreadRadius: 0.0, color: Color(0xFFBEBEBE))
            ],
          ),
          child: _animation.value <= 0.5
              ? _userEvent(
                  child: _card(),
                )
              : GestureDetector(
                  child: _backSide('assets/images/ability_back.jpg'),
                )),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _transformation({required Widget child}) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()..rotateY(pi * _animation.value),
      child: child,
    );
  }

  Widget _userEvent({required Widget child}) {
    return GestureDetector(
      child: child,
      behavior: HitTestBehavior.opaque,
      onLongPress: () {
        if (_animationStatus == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      },
    );
  }

  Widget _card() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_leftSide(), _rightSide()],
    );
  }

  Widget _backSide(String imagePath) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Stack(
        children: [
          /// background image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(widget.getRadius()),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imagePath),
              ),
            ),
          ),

          /// title
          SizedBox.expand(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Builder(
                  builder: (BuildContext context) {
                    return Text(
                      'Bandit Guard',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              offset: Offset(1.5, 1.5),
                              color: Color(0xFF333333))
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          /// Action buttons
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _backSideButton(Icons.arrow_back_rounded, () => _animationController.reverse()),
                _backSideButton(Icons.delete_rounded, () {}),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _backSideButton(IconData icon, VoidCallback action) {
    return Builder(
      builder: (BuildContext context) {
        return ElevatedButton(
          onPressed: action,
          child: Icon(icon),
          style: ElevatedButton.styleFrom(primary: Colors.blueGrey.withOpacity(0.65), padding: EdgeInsets.all(15), shape: CircleBorder()),
        );
      },
    );
  }

  /// Left side of the card
  Widget _leftSide() {
    return Expanded(
      flex: 1,
      child: CardImage(
        heightConstrain: widget.height,
        imagePath: 'assets/unit_images/Bandit-Guard-214x300.jpg',
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
