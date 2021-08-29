import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/common/mixins/grid_axis_counter_mixin.dart';

class GHSliverGrid extends StatelessWidget with GridAxisCounter {
  final List<Widget> children;
  final double? padding;
  final double childWidth, childHeight;

  GHSliverGrid({
    Key? key,
    required landscape,
    required portrait,
    required this.children,
    this.childWidth = 3,
    this.childHeight = 2,
    this.padding
  }) {
    this.landscape = landscape;
    this.portrait = portrait;
  }

  @override
  Widget build(BuildContext context) {
    Widget current = SliverGrid.count(
      crossAxisCount: getCrossAxisCount(MediaQuery.of(context).orientation),
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 0,
      childAspectRatio: childWidth / childHeight,
      children: children,
    );

    if (padding != null) {
      current = SliverPadding(padding: EdgeInsets.all(padding!), sliver: current,);
    }

    return current;
  }
}
