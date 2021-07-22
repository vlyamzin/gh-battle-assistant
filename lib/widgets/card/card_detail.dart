import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({Key? key}) : super(key: key);

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
