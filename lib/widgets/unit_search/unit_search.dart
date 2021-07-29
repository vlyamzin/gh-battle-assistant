import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/services/unit_service.dart';

typedef ParamCallback = void Function(MapEntry<UnitType, String>?);

class UnitSearch extends StatefulWidget {
  final ParamCallback onSelectedCallback;

  UnitSearch({Key? key, required this.onSelectedCallback}) : super(key: key);

  @override
  _UnitSearchState createState() => _UnitSearchState();
}

class _UnitSearchState extends State<UnitSearch> {
  final _controller = CupertinoSuggestionsBoxController();
  final _typeaheedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _typeaheedController.addListener(() {
      if (_typeaheedController.text.isEmpty) widget.onSelectedCallback(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTypeAheadFormField(
          getImmediateSuggestions: true,
          onSuggestionSelected: (String itemName) {
            var item = UnitService.itemByName(itemName);

            assert(item != null);
            if (item != null) _typeaheedController.text = item.value;
            widget.onSelectedCallback(item);
          },
          suggestionsBoxController: _controller,
          textFieldConfiguration: CupertinoTextFieldConfiguration(
            controller: _typeaheedController,
            placeholder: 'Search',
            prefixMode: OverlayVisibilityMode.always,
            clearButtonMode: OverlayVisibilityMode.editing,
            prefix: Icon(Icons.search, color: Color(0xff7f7f82)),
            decoration: BoxDecoration(
              color: Color(0xFFECECEE),
              borderRadius: BorderRadius.all(Radius.circular(5)),

            )
          ),
          itemBuilder: (context, String suggestions) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                  ),
                ),
                child: Text(suggestions));
          },
          suggestionsCallback: (query) {
            return UnitService.getSuggestions(query).values;
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _typeaheedController.dispose();
    super.dispose();
  }
}
