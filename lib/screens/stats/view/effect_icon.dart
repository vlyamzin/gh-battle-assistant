import 'package:flutter/widgets.dart';
import 'package:gh_battle_assistant/screens/stats/stats.dart';

class EffectIcon extends StatelessWidget {
  final Effect? effect;

  const EffectIcon({Key? key, this.effect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: key,
      width: 40,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: effect != null
            // ? Image(image: AssetImage(effect!.iconShortcut))
            ? Image.asset(
                effect!.iconShortcut,
                width: 40,
                errorBuilder: (_, __, ___) =>
                    errorHandler(effect!.iconShortcut),
              )
            : Container(),
      ),
    );
  }

  /// Workaround for [ActivitySelector] unable to show icons for the first time
  /// It happens because [CupertinoPicker] has a bug with showing Image.assets pictures
  /// It cannot calculate a size for dynamically loaded images
  /// The workaround described here https://github.com/flutter/flutter/issues/61228#issuecomment-916222284
  Widget errorHandler(imageURI) {
    return Image.asset(
      effect!.iconShortcut,
      width: 40,
      errorBuilder: (_, __, ___) => SizedBox(),
    );
  }
}
