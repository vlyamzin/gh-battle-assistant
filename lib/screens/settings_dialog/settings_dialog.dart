import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/screens/settings_dialog/controllers/settings_controller.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.0, -0.5),
      child: FractionallySizedBox(
        widthFactor: 0.6,
        heightFactor: 0.5,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: 0.1,
                color: Color(0xFF797979),
              ),
            ],
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              _HeaderBar(),
              _Body(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF9F9F9),
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xFFEAEAEA)),
          )),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            child: Text('Back'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text('Settings'),
          CupertinoButton(
            child: Text('Save'),
            onPressed: () => context
                .read<SettingsController>()
                .saveSettings()
                .then((status) {
              if (status == true)
                Navigator.of(context).pop();
              else
                throw Exception('Settings are not saved');
            }),
          )
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Column(
        children: [
          _BodyItem(
            label: 'Difficulty',
            control: _DifficultyControl(),
          ),
        ],
      ),
    );
  }
}

class _BodyItem extends StatelessWidget {
  const _BodyItem({
    Key? key,
    required this.label,
    required this.control,
  }) : super(key: key);

  final String label;
  final Widget control;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              control,
            ],
          )
        ],
      ),
    );
  }
}

class _DifficultyControl extends StatelessWidget {
  const _DifficultyControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsController>(
      builder: (_, controller, __) => IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              child: Icon(Icons.remove),
              onPressed: () => controller.decreaseDifficulty(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            Text('${controller.difficulty}'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            CupertinoButton(
              child: Icon(Icons.add),
              onPressed: () => controller.increaseDifficulty(),
            ),
          ],
        ),
      ),
    );
  }
}