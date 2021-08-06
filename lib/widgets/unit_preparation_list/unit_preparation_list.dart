import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/models/add_unit_provider.dart';
import 'package:provider/provider.dart';

class UnitPreparationList extends StatelessWidget {

  const UnitPreparationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddUnitProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.fromLTRB(10, 65, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _title(),
              Expanded(
                child: _list(provider)
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _title() {
    return Text(
      'Prepare the next units',
      textAlign: TextAlign.center,
      textScaleFactor: 3,
    );
  }

  Widget _list(AddUnitProvider provider) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: provider.stack?.units.length ?? 0,
      itemBuilder: (context, int index) {
        if (provider.stack != null) {
          var unit = provider.stack!.units[index];
          // return Text('${provider.stack!.units[index]}');
          return _listItem(unit.displayName, unit.number, unit.elite);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _listItem(String name, int? id, bool? highlight) {
    return Container(
      decoration: BoxDecoration(
        color: (highlight != null && highlight) ? Colors.amber : null,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Text('$id: $name'),
    );
  }
}
