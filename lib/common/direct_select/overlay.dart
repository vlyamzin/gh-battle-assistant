import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySelectionOverlay extends StatefulWidget {
  final double top;
  final double left;
  final double width;
  final double height;
  final Widget? child;
  final Color? backgroundColor;

  const MySelectionOverlay({
    Key? key,
    required this.top,
    required this.left,
    this.width = 200,
    this.height = 300,
    this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  MySelectionOverlayState createState() {
    return MySelectionOverlayState();
  }
}

class MySelectionOverlayState extends State<MySelectionOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 230),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Positioned(
      top: widget.top,
      left: widget.left,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: widget.backgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: ScaleTransition(
                scale: Tween(begin: 1.0, end: 1.12).animate(_controller),
                child: FadeTransition(
                  child: widget.child,
                  opacity: Tween(begin: 0.0, end: 1.0).animate(_controller),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void reverse(OverlayEntry? overlayEntry) {
    _controller.reverse().whenComplete(() => overlayEntry!.remove());
  }
}

class MySelectionList extends StatelessWidget {
  final FixedExtentScrollController? controller;
  final IndexedWidgetBuilder builder;
  final int childCount;
  final ValueChanged<int> onItemChanged;
  final VoidCallback onItemSelected;
  final double? itemExtent;
  final double? itemMagnification;
  final Color? selectionColor;

  const MySelectionList({
    Key? key,
    required this.controller,
    required this.builder,
    required this.childCount,
    required this.onItemChanged,
    required this.onItemSelected,
    required this.itemExtent,
    required this.itemMagnification,
    required this.selectionColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            onItemSelected();
          }
          return false;
        },
        child: CupertinoPicker.builder(
          scrollController: controller,
          offAxisFraction: 0.0,
          itemExtent: itemExtent!,
          childCount: childCount,
          useMagnifier: true,
          magnification: itemMagnification!,
          diameterRatio: 3.0,
          onSelectedItemChanged: onItemChanged,
          selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: selectionColor!),
          itemBuilder: builder,
        ),
      ),
    );
  }
}
