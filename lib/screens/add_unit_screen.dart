import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/widgets/add_unit_form/add_unit_form.dart';

class AddUnitScreen extends StatefulWidget {
  const AddUnitScreen({Key? key}) : super(key: key);

  @override
  _AddUnitScreenState createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  bool _formSubmitter = false;
  StreamController _triggerFormSubmission = StreamController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _navBar(context),
      child: AddUnitForm(
        submit: _triggerFormSubmission.stream,
        onSubmitted: () {
          setState(() {
            _formSubmitter = true;
          });
        },
      ),
    );
  }

  CupertinoNavigationBar _navBar(BuildContext context) {
    return CupertinoNavigationBar(
      leading: CupertinoNavigationBarBackButton(
        onPressed: () => Navigator.pop(context),
      ),
      middle: Text('Add Unit'),
      trailing: CupertinoButton(
        padding: EdgeInsets.all(0),
        onPressed: _formSubmitter ? _closeScreen : _submitForm,
        child: _formSubmitter ? Text('Done') : Text('Add'),
      ),
    );
  }

  void _submitForm() {
    _triggerFormSubmission.add(null);
  }

  void _closeScreen() {
    // TODO create/update stack with new units
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _triggerFormSubmission.close();
    super.dispose();
  }
}
