import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/common/mixins/card_border_radius_mixin.dart';

class CardImage extends StatelessWidget with CardBorderRadius {
  const CardImage(
      {Key? key, required this.heightConstrain, required this.imagePath})
      : super(key: key);

  final double heightConstrain;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: heightConstrain),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: getRadius(),
          bottomLeft: getRadius(),
        ),
        child: Image(
          fit: BoxFit.fitHeight,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}
