import 'package:cloud_functions/cloud_functions.dart';

class EmailService {
  String to;
  EmailService({required this.to});

  void sendBidInMail(String tenant, String bidDocId, String creator) async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    try {
      HttpsCallable callable = functions.httpsCallable('getCurrentBidData');
      await callable({
        "clientMail": to,
        "tenantId": tenant,
        "bidDocId": bidDocId,
        "creator": creator
        // "ClientPhone": customerPhone,
      });
    } catch (err) {
      print(err);
    }
  }
}
