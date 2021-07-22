import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/widgets/card/card.dart';
import 'package:gh_battle_assistant/common/grid.dart';
import 'package:gh_battle_assistant/screens/add_unit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // TODO remove
  final cardList = const <int>[1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _navBar(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _gridView(context),
      ),
    );
  }

  CupertinoNavigationBar _navBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: const Text('Gloomhaven Battle Assistant'),
      trailing: Container(
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).push(_addUnitRoute()),
          child: Text('Add Unit'),
        ),
      ),
    );
  }

  /// Add extra route with [AddUnitScreen] widget
  CupertinoPageRoute _addUnitRoute() {
    return CupertinoPageRoute(builder: (_) => AddUnitScreen());
  }

  /// Create [GridView] widget with unit cards in it
  Widget _gridView(BuildContext context) {
    final cardWidth = _screenSize(context) / 2;
    final double cardHeight = MediaQuery.of(context).orientation == Orientation.portrait ? 300 : 400;

    return Grid(
      landscape: 3,
      portrait: 2,
      children: cardList.map((int value) {
        return Card(
          key: ValueKey(value),
          width: cardWidth,
          height: cardHeight,
        );
      }).toList(),
      childWidth: cardWidth,
      childHeight: cardHeight,
    );
  }

  /// Get screen size
  double _screenSize(BuildContext context) => MediaQuery.of(context).size.width;
}
