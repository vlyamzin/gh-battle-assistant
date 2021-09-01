import 'package:flutter/cupertino.dart';

class AnimatedFlipBaseState<T extends StatefulWidget> extends State<T> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  AnimationStatus animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addStatusListener((AnimationStatus status) {
        animationStatus = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void animationForward() {
    if (animationStatus == AnimationStatus.dismissed) {
      animationController.forward();
    }
  }

  void animationBackward() {
    animationController.reverse();
  }
}
