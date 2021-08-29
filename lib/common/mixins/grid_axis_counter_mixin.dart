
import 'package:flutter/cupertino.dart';

mixin GridAxisCounter {
  late final int landscape, portrait;

  int getCrossAxisCount(Orientation orientation) {
    return orientation == Orientation.landscape ? landscape : portrait;
  }
}
