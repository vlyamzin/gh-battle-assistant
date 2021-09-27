import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/models/enums/unit_normality.dart';
import 'package:gh_battle_assistant/models/enums/unit_type.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

import '../../di.dart';

class UnitPortrait extends StatelessWidget {
  final int unitNumber;
  final UnitType type;
  final UnitNormality normality;

  const UnitPortrait({
    Key? key,
    required this.unitNumber,
    required this.type,
    required this.normality,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            fit: BoxFit.contain,
            image: AssetImage(
                di<ImageService>().getUnitPortraitByType(type, normality)),
          ),
          Center(
            child: Text(
              unitNumber.toString(),
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'Nyala',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1.5, 1.5),
                    color: Color(0xFF333333),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
