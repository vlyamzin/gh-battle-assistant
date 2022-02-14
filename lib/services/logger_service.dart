class LoggerService {
  void log(String msg, [Object? caller]) {
    var prefix = caller != null ? '$caller:' : '';
    print('$prefix $msg');
  }
}
