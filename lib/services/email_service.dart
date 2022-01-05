import 'package:cloud_functions/cloud_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailService {
  final String to;
  EmailService({required this.to});

  void sendBidInMail(String tenant, String bidDocId, String creator) async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    // try {
    //   HttpsCallable callable = functions.httpsCallable('getCurrentBidData');
    //   await callable({
    //     "clientMail": to,
    //     "tenantId": tenant,
    //     "bidDocId": bidDocId,
    //     "creator": creator
    //     // "ClientPhone": customerPhone,
    //   });
    // } catch (err) {
    //   print(err);
    // }
  }

  Future<void> openDefaultMainAppWithAddressClient() async {
    final _url = 'mailto:$to';
    if (!await launch(_url)) {
      throw 'Could not launch $_url';
    } else {
      await launch(_url);
    }
  }
}
