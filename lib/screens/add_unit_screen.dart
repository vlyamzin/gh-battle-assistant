import 'package:flutter/cupertino.dart';

class AddUnitScreen extends StatelessWidget {
  const AddUnitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _navBar(context),
      child: ListView(
        children: [
          Text('test')
        ],
      ),
    );
  }

  CupertinoNavigationBar _navBar(BuildContext context) {
    return CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text('Add Unit'));
  }
}
