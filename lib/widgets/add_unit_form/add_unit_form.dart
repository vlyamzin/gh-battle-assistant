import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/widgets/add_unit_form/elite_number_input.dart';
import 'package:gh_battle_assistant/widgets/add_unit_form/unit_number_input.dart';
import 'package:gh_battle_assistant/widgets/unit_search/unit_search.dart';

class AddUnitForm extends StatefulWidget {
  final Function? onSubmitted;
  final Stream submit;
  const AddUnitForm({Key? key, this.onSubmitted, required this.submit}) : super(key: key);

  @override
  _AddUnitFormState createState() => _AddUnitFormState();
}

class _AddUnitFormState extends State<AddUnitForm> {
  final _formKey = GlobalKey<FormState>();
  MapEntry<UnitType, String>? _unitType;
  int? unitNumber, eliteNumber;
  String unitNumberInputError = 'required';
  String eliteNumberInputError = 'required';
  final _unitNumberCtrl = TextEditingController();
  final _eliteNumberCtrl = TextEditingController();
  StreamSubscription? _sub;

  @override
  void initState() {
    _sub = widget.submit.listen((_) {
      print('Bingo!');
      if (_formKey.currentState != null &&
          _formKey.currentState!.validate()) {
        // TODO generate new Units;
        if (widget.onSubmitted != null) widget.onSubmitted!();
      }
    });
    _unitNumberCtrl.addListener(() {
      setState(() {});
    });
    _eliteNumberCtrl.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            UnitSearch(
              onSelectedCallback: (item) {
                setState(() => _unitType = item);
              },
            ),
            _unitNumberInput(),
            Padding(padding: EdgeInsets.all(20)),
          ],
        ),
      ),
    );
  }

  Widget _unitNumberInput() {
    return _unitType != null
        ? CupertinoFormSection(
            children: [
              // TODO add maxValue which is based on UnitType
              UnitNumberInput(controller: _unitNumberCtrl, maxValue: '6',),
              EliteNumberInput(controller: _eliteNumberCtrl, maxValue: _unitNumberCtrl.text),
            ],
          )
        : Container();
  }

  @override
  void dispose() {
    _sub!.cancel();
    _unitNumberCtrl.dispose();
    _eliteNumberCtrl.dispose();
    super.dispose();
  }
}
