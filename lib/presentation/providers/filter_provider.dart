import 'package:flutter/foundation.dart';

class FilterProvider with ChangeNotifier {
  int filterIndex = 0;

  int get getFilterIndex => filterIndex;
  void updateFilterIndex({required int newIndex}) {
    if (newIndex < 0 || newIndex > 4) {
      return;
    }
    filterIndex = newIndex;
    notifyListeners();
    print(getFilterIndex);
  }
}
