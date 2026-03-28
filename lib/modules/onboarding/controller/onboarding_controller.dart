import 'package:flutter/widgets.dart';

class OnBoardingController extends ChangeNotifier {
  int selectedIndex = 0;

  changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}


