import 'package:flutter/cupertino.dart';

class ComboProvider extends ChangeNotifier {
  List _comboList = [];

  get getCombo => _comboList;

  set setValueCombo(value) {
    _comboList = value;
    notifyListeners();
  }

  changeFavoritStatus(int ident) {
    for (int i = 0; i < _comboList.length; i++) {
      if (_comboList[i]['ident'] == ident) {
        _comboList[i]['favorit'] = !_comboList[i]['favorit'];
      }
    }
    notifyListeners();
  }
}
