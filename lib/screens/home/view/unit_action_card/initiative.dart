import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/services/image_service.dart';

class Initiative extends StatelessWidget {
  final int? value;
  const Initiative({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImageService.initiativeBackground),
            fit: BoxFit.fill),
      ),
      child: Text(
        value != null ? value.toString() : '',
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'PirataOne',
        ),
      ),
    );
  }
}
