import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gh_battle_assistant/models/unit_action.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

import '../../di.dart';

class UnitActionRecord extends StatelessWidget {
  final GHAction record;

  const UnitActionRecord({Key? key, required this.record}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _mainBlock()),
          record.area != null ? _AreaEffect(area: record.area!) : Container(),
        ],
      ),
    );
  }

  Widget _mainBlock() {
    final current = <Widget>[];

    assert(record.title != null, 'No action title has been provided');

    if (record.title != null) {
      current.add(_title(record.title!));
    }

    if (record.subtitle != null) {
      current.add(_subtitle(record.subtitle!));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: current,
    );
  }

  Widget _title(String str) {
    return _RecordString(
        str: str,
        textStyle: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontFamily: 'Nyala',
            fontWeight: FontWeight.w600));
  }

  Widget _subtitle(String str) {
    return _RecordString(
      str: str,
      textStyle: TextStyle(
        fontFamily: 'Nyala',
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}

String _replaceWithIconPath(String str) {
  return str.replaceAllMapped(RegExp(r'%\w+%'), (Match match) {
    var iconKey = match.group(0) ?? '';
    iconKey = iconKey.replaceAll('%', '');
    return di<ImageService>().getIcon(iconKey, IconSize.s32);
  });
}

class _RecordString extends StatelessWidget {
  final String str;
  final TextStyle textStyle;

  const _RecordString({
    Key? key,
    required this.str,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final segments = _splitString(str);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textStyle,
        children: segments.map((str) {
          if (RegExp(r'%').hasMatch(str)) {
            return WidgetSpan(
              alignment: PlaceholderAlignment.middle,
                child: Image(
              image: AssetImage(_replaceWithIconPath(str)),
            ));
          } else {
            return TextSpan(text: str);
          }
        }).toList(),
      ),
    );
  }

  List<String> _splitString(String str) => str.split('|');
}

class _AreaEffect extends StatelessWidget {
  final String area;
  
  const _AreaEffect({Key? key, required this.area}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(image: AssetImage(_replaceWithIconPath(area)),),
    );
  }
}
