import 'package:flutter/cupertino.dart';
import 'package:gh_battle_assistant/models/enums/add_unit_form_status.dart';

class AddUnitScreenProvider with ChangeNotifier {
  FormStatus _formStatus = FormStatus.pristine;

  FormStatus get formStatus => _formStatus;

  set formStatus(FormStatus status) {
    _formStatus = status;
    notifyListeners();
  }
}
