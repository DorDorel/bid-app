import 'package:bid/providers/tenant_provider.dart';
import 'package:cloud_functions/cloud_functions.dart';

class BidFlowRunner {
  String bidDocId;
  String customerEmail;
  String customerPhone;
  BidFlowRunner(
      {required this.bidDocId,
      required this.customerEmail,
      required this.customerPhone});

  FirebaseFunctions functions = FirebaseFunctions.instance;

  Future<void> runner() async {
    final tenant = TenantProvider().tenantId;

    print('here cloud functnio runing');

    // try {
    //   HttpsCallable callable = functions.httpsCallable('getCurrentBidData');
    //   await callable({
    //     "tenantId": tenant,
    //     "clientMail": customerEmail,
    //     "ClientPhone": customerPhone,
    //   });
    // } catch (err) {
    //   print(err);
    // }
  }
}
