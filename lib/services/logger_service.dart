class LoggerService {
  void print(String msg, [Object? caller]) {
    var prefix = caller != null ? '$caller:' : '';
    print('$prefix $msg');
  }
}
