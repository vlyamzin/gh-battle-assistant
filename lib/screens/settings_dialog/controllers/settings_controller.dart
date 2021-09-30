import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController with ChangeNotifier {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  int difficulty = 0;

  Future<void> loadSettings() async {
    var snapshot = await _pref;
    difficulty = snapshot.getInt('difficulty') ?? 0;
  }

  void increaseDifficulty() {
    if (difficulty < 7) {
      difficulty += 1;
      notifyListeners();
    }
  }

  void decreaseDifficulty() {
    if (difficulty > 0) {
      difficulty -= 1;
      notifyListeners();
    }
  }

  Future<bool> saveSettings() async {
    var prefSnapshot = await _pref;
    return prefSnapshot
        .setInt('difficulty', difficulty)
        .then((bool status) => status);
  }
}
