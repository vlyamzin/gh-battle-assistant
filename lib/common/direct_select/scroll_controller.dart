import 'package:flutter/cupertino.dart';

class ModFixedExtentScrollController extends FixedExtentScrollController {
  ModFixedExtentScrollController(int initialItem)
      : super(initialItem: initialItem);

  /// Allow us to access the protected getter [ScrollController.positions].
  bool get hasScrollPositions => positions.isNotEmpty;
}
