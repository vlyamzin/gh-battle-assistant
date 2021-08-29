import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/models/unit_action.dart';

class UnitActionRecord extends StatelessWidget {
  final GHAction record;

  const UnitActionRecord({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _mainBlock()),
        ],
      ),
    );
  }

  Widget _mainBlock() {
    final current = <Widget>[];

    assert(record.title != null, 'No action title has been provided');

    if (record.title != null) {
      current.add(_title(record.title!));
    }

    if (record.subtitle != null) {
      current.add(_subtitle(record.subtitle!));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: current,
    );
  }

  Text _title(String str) {
    return Text(
      str,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),);
  }

  Text _subtitle(String str) {
    return Text(
      str,
      textAlign: TextAlign.center,
    );
  }
}
