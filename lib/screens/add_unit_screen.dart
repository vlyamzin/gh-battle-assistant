import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/back/game_data.dart';
import 'package:gh_battle_assistant/models/add_unit_provider.dart';
import 'package:gh_battle_assistant/widgets/add_unit_form/add_unit_form.dart';
import 'package:gh_battle_assistant/widgets/unit_preparation_list/unit_preparation_list.dart';
import 'package:provider/provider.dart';

class AddUnitScreen extends StatefulWidget {
  const AddUnitScreen({Key? key}) : super(key: key);

  @override
  _AddUnitScreenState createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  StreamController _triggerFormSubmission = StreamController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddUnitScreenProvider()),
        ProxyProvider<GameData, AddUnitProvider>(
          update: (BuildContext context, gameData, _) =>
              AddUnitProvider(data: gameData),
        )
      ],
      child: Consumer<AddUnitScreenProvider>(
        builder: (context, provider, child) {
          return CupertinoPageScaffold(
            navigationBar: _navBar(context, provider),
            child: Builder(
              builder: (_) {
                if (provider.formStatus == FormStatus.pristine) {
                  return AddUnitForm(
                    submit: _triggerFormSubmission.stream,
                    onSubmitted: (stack) {
                      print(stack);
                      provider.formStatus = FormStatus.submitted;
                    },
                  );
                } else {
                  return UnitPreparationList();
                }
              },
            )
          );
        },
      ),
    );
  }



  CupertinoNavigationBar _navBar(BuildContext context, AddUnitScreenProvider provider) {
    return CupertinoNavigationBar(
      leading: CupertinoNavigationBarBackButton(
        onPressed: () => Navigator.pop(context),
      ),
      middle: Text('Add Unit'),
      trailing: CupertinoButton(
        padding: EdgeInsets.all(0),
        onPressed: provider.formStatus == FormStatus.submitted ? () => _closeScreen(context) : _submitForm,
        child: provider.formStatus == FormStatus.submitted ? Text('Done') : Text('Add'),
      ),
    );
  }

  void _submitForm() {
    _triggerFormSubmission.add(null);
  }

  void _closeScreen(BuildContext context) {
    // TODO get GameDataModel
    // TODO check if there is a stack there
    // TODO create/update stack with new units
    throw UnimplementedError();
    // Navigator.pop(context);
  }

  @override
  void dispose() {
    _triggerFormSubmission.close();
    super.dispose();
  }
}
