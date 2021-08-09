import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/models/add_unit_provider.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/models/home_screen_provider.dart';
import 'package:gh_battle_assistant/models/unit_stack.dart';
import 'package:gh_battle_assistant/widgets/add_unit_form/elite_number_input.dart';
import 'package:gh_battle_assistant/widgets/add_unit_form/unit_number_input.dart';
import 'package:gh_battle_assistant/widgets/unit_search/unit_search.dart';
import 'package:provider/provider.dart';

class AddUnitForm extends StatefulWidget {
  final Function(UnitStack data)? onSubmitted;
  final Stream submit;

  const AddUnitForm({Key? key, this.onSubmitted, required this.submit})
      : super(key: key);

  @override
  _AddUnitFormState createState() => _AddUnitFormState();
}

class _AddUnitFormState extends State<AddUnitForm> {
  final _formKey = GlobalKey<FormState>();
  String unitNumberInputError = 'required';
  String eliteNumberInputError = 'required';
  final _unitNumberCtrl = TextEditingController();
  final _eliteNumberCtrl = TextEditingController();
  late final StreamSubscription _sub;

  @override
  void initState() {
    final provider = context.read<AddUnitProvider>();

    _sub = widget.submit.listen((_) {
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        provider.addUnitsToStack();

        if (widget.onSubmitted != null) widget.onSubmitted!(provider.stack!);
      }
    });
    _unitNumberCtrl.addListener(() {
      setState(() {
        provider.unitNumber = _unitNumberCtrl.text.isNotEmpty
            ? int.parse(_unitNumberCtrl.text)
            : 0;
      });
    });
    _eliteNumberCtrl.addListener(() {
      setState(() {
        provider.eliteNumber = _eliteNumberCtrl.text.isNotEmpty
            ? int.parse(_eliteNumberCtrl.text)
            : 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<AddUnitProvider>();
    return Consumer<AddUnitProvider>(
      builder: (context, provider, child) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                UnitSearch(
                  onSelectedCallback: (item) =>
                      _onTypeaheadSelect(context, provider, item),
                ),
                _unitNumberInput(provider),
                Padding(padding: EdgeInsets.all(20)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _unitNumberInput(AddUnitProvider provider) {
    return provider.stack != null
        ? CupertinoFormSection(
      children: [
        UnitNumberInput(
          controller: _unitNumberCtrl,
          maxValue: provider.getMaxUnitNumberToAdd(),
        ),
        EliteNumberInput(
            controller: _eliteNumberCtrl, maxValue: _unitNumberCtrl.text),
      ],
    )
        : Container();
  }

  void _onTypeaheadSelect(BuildContext context, AddUnitProvider provider,
      MapEntry<UnitType, String>? item) {
    if (item != null) {
      provider.initUnitStack(
          item.key, item.value, context.read<HomeScreenProvider>());
    } else {
      provider.clearUnitStack();
    }

    setState(() => {});
  }

  @override
  void dispose() {
    _sub.cancel();
    _unitNumberCtrl.dispose();
    _eliteNumberCtrl.dispose();
    super.dispose();
  }
}
