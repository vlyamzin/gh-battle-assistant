import 'dart:math';

class UtilService {
  late final Random _random;

  UtilService() {
    this._random = Random();
  }

  int randomize(int max) => _random.nextInt(max);
}
