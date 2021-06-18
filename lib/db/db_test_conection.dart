import 'package:cloud_functions/cloud_functions.dart';

class DbTestConnection {
  Future<void> getFunctionsTestConnection() async {
    HttpsCallable testConnection =
        FirebaseFunctions.instance.httpsCallable('testConection');
    final result = await testConnection();
    print(result.data);
  }
}
