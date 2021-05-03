import 'package:flutter/cupertino.dart';

class RestorantsProvider extends ChangeNotifier {
  List _restorants = [];
  get getRestorants => _restorants;

  set setValueRestorants(value) {
    _restorants = value;
    notifyListeners();
  }
}
