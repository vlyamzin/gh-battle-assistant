import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Card extends StatelessWidget {
  const Card({Key? key, required this.width, required this.height})
      : super(key: key);

  final double width, height;

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
        borderRadius: BorderRadius.all(Radius.circular(7)),
        boxShadow: [
          BoxShadow(
              blurRadius: 3.0, spreadRadius: 0.0, color: Color(0xFFBEBEBE))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _leftSide(),
          _rightSide()
        ],
      ),
    );
  }

  /// Left side of the card
  Widget _leftSide() {
    return Expanded(
      flex: 1,
      child: _CardImage(
        heightConstrain: height,
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
          _CardTitle(),
          Flexible(
            flex: 1,
            child: _CardDetail(),
          )
        ],
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage(
      {Key? key, required this.heightConstrain, required this.imagePath})
      : super(key: key);

  final double heightConstrain;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: heightConstrain),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7),
          bottomLeft: Radius.circular(7),
        ),
        child: Image(
          fit: BoxFit.fitHeight,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({Key? key}) : super(key: key);

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
            child: Text('Bandit Guard'),
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: Text(
              '99',
              style: TextStyle(fontSize: 15),
            ),
          ),
        )
        // SizedBox(child: Text('55'), width: 30, height: 30,)
      ],
    );
  }
}

class _CardDetail extends StatelessWidget {
  const _CardDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Attack -1'),
            Text('Range -2'),
            Text('Range -2'),
            Text('Range -2'),
            Text('dasd asd asd asd a'),
            Text('Range -2'),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SizedBox(
            width: 50,
            height: 50,
            child: Center(child: Icon(Icons.refresh)),
          ),
        ),
      ],
    );
  }
}
