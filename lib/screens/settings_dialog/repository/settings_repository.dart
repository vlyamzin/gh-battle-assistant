import 'package:gh_battle_assistant/screens/settings_dialog/model/settings.dart';

class SettingsRepository {
  Settings? _settings;

  void set settings(Settings data) => _settings = data;

  Settings loadSettings() {
    assert(_settings != null);
    if (_settings != null)
      return _settings!;
    else
      throw Exception('Settings object is not defined');
  }
}
