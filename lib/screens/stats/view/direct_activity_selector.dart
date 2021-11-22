import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/common/direct_select/widget.dart';

class DirectActivitySelector extends StatefulWidget {
  static const defaultValues = ['attack', 'heal', '1', '2', '3'];
  const DirectActivitySelector({Key? key}) : super(key: key);

  @override
  State<DirectActivitySelector> createState() => _DirectActivitySelectorState();
}

class _DirectActivitySelectorState extends State<DirectActivitySelector> {
  var index = 1;

  @override
  Widget build(BuildContext context) {
    return DirectSelect(
      items: DirectActivitySelector.defaultValues
          .map(
            (e) => SizedBox(
              height: 60,
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: FittedBox(
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
      backgroundColor: Color(0x50FFFFFF),
      selectedIndex: index,
      onSelectedItemChanged: (i) {
        setState(() {
          index = i ?? index;
        });
      },
      itemExtent: 35.0,
      child: SizedBox(
        height: 60,
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: FittedBox(
              child: Text(DirectActivitySelector.defaultValues[index])),
        ),
      ),
    );
  }
}
