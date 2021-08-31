import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StoreService {
  final fileName = 'state.json';

  Future<String> read() async {
    final file = await _localFile;
    return await file.readAsString();
  }

  Future<void> write(Map<String, dynamic> data) async {
    final file = await _localFile;
    file.writeAsString(jsonEncode(data));
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    // print('Store path: ${directory.path}');

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }
}
