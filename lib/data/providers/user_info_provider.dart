import 'package:bid/data/db/database.dart';
import 'package:bid/data/models/user.dart';
import 'package:flutter/foundation.dart';

class UserInfoProvider with ChangeNotifier {
  CustomUser? userData;

  Future<void> fetchUserData() async {
    userData ?? await _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      final user = await DatabaseService().getUserDataFromUserCollection();

      if (user == null) {
        print("Problem with user model sync");
      }
      userData = user;
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

  void clearUserDataFromMemory() {
    userData = null;
    notifyListeners();
  }
}
