import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  List _categoryList = [];

  get getCategoryList => _categoryList;

  set setValueCategory(value) {
    _categoryList = value;
    notifyListeners();
  }

  changeStatusFavorit(int ident) {
    for (int i = 0; i < _categoryList.length; i++) {
      for (int j = 0; j < _categoryList[i]['menyu'].length; j++) {
        if (_categoryList[i]['menyu'][j]['ident'] == ident) {
          _categoryList[i]['menyu'][j]['favorit'] =
              !_categoryList[i]['menyu'][j]['favorit'];
        }
      }
    }
    notifyListeners();
  }
}
