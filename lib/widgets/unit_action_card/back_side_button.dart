import 'package:flutter/material.dart';

class BackSideButton extends StatelessWidget {
  final VoidCallback action;
  final IconData icon;

  const BackSideButton({
    Key? key,
    required this.action,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return ElevatedButton(
          onPressed: action,
          child: Icon(icon),
          style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey.withOpacity(0.65),
              padding: EdgeInsets.all(15),
              shape: CircleBorder()),
        );
      },
    );
  }
}
