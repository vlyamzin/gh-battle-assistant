import 'package:flutter/widgets.dart';

/// Custom [GridView] widget that align items based on provided [landscape] and [portrait] sizes

class Grid extends StatelessWidget {
  const Grid({
    Key? key,
    required this.landscape,
    required this.portrait,
    required this.children,
    this.childWidth = 3,
    this.childHeight = 2,
  }) : super(key: key);

  final int landscape, portrait;
  final List<Widget> children;
  final double childWidth, childHeight;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 20,
      crossAxisSpacing: 0,
      crossAxisCount: _getCrossAxisCount(MediaQuery.of(context).orientation),
      childAspectRatio: childWidth / childHeight,
      children: children,
    );
  }

  int _getCrossAxisCount(Orientation orientation) {
    return orientation == Orientation.landscape ? landscape : portrait;
  }
}
