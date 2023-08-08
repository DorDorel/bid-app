import 'package:flutter/foundation.dart';

class FilterProvider with ChangeNotifier {
  int _filterIndex = 0;

  int get getFilterIndex => _filterIndex;

  void updateFilterIndex({required int newIndex}) {
    if (newIndex < 0 || newIndex > 4) {
      return;
    }
    _filterIndex = newIndex;
    notifyListeners();
  }
}

