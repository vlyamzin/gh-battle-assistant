import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gh_battle_assistant/screens/add_unit/add_unit.dart';
import 'package:provider/provider.dart';

class UnitSearchInput extends StatefulWidget {
  UnitSearchInput({Key? key}) : super(key: key);

  @override
  _UnitSearchInputState createState() => _UnitSearchInputState();
}

class _UnitSearchInputState extends State<UnitSearchInput> {
  final _controller = CupertinoSuggestionsBoxController();
  final _typeaheedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddUnitCubit, AddUnitState>(
      listener: (context, state) {
        _initControllerText(state);
      },
      builder: (context, state) {
        _initControllerText(state);

        return CupertinoTypeAheadFormField(
          getImmediateSuggestions: true,
          onSuggestionSelected: (String itemName) {
            context.read<AddUnitCubit>().selectUnitType(itemName);
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
              )),
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
            return context.read<AddUnitCubit>().getSuggestion(query).values;
          },
        );
      },
    );
  }

  void _initControllerText(AddUnitState state) {
    if (state is UnitTypeSelectedS) {
      _typeaheedController.text = state.stack.displayName;
    }
  }
}
