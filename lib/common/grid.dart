import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/common/mixins/grid_axis_counter_mixin.dart';

/// Custom [GridView] widget that align items based on provided [landscape] and [portrait] sizes

class Grid extends StatelessWidget with GridAxisCounter {

  Grid({
    Key? key,
    required landscape,
    required portrait,
    required this.children,
    this.childWidth = 3,
    this.childHeight = 2,
  }) {
    this.landscape = landscape;
    this.portrait = portrait;
  }

  final List<Widget> children;
  final double childWidth, childHeight;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 20,
      crossAxisSpacing: 0,
      crossAxisCount: getCrossAxisCount(MediaQuery.of(context).orientation),
      childAspectRatio: childWidth / childHeight,
      children: children,
    );
  }
}
