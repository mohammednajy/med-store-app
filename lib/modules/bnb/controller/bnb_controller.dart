import 'package:flutter/material.dart';

class BnbController extends ChangeNotifier {
  int selectedTabIndex = 0;

  changeIndex(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }
}
