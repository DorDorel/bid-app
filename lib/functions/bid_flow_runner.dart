import 'package:bid/models/bid.dart';
import 'package:bid/providers/tenant_provider.dart';
import 'package:cloud_functions/cloud_functions.dart';

class BidFlowRunner {
  Bid bid;
  BidFlowRunner({required this.bid});

  FirebaseFunctions functions = FirebaseFunctions.instance;

  Future<void> runner() async {
    final tenant = TenantProvider().tenantId;
    final createdBy = bid.createdBy;
    final date = bid.date;
    final clientMail = bid.clientMail;
    final clientName = bid.clientName;
    final finalPrice = bid.finalPrice;
    final selectedProduct = bid.selectedProducts;

    try {
      HttpsCallable callable = functions.httpsCallable('createBidFlowRunner');
      await callable({
        "tenantId": tenant,
        "createdBy": createdBy,
        "date": date,
        "clientMail": clientMail,
        "clientName": clientName,
        "finalPrice": finalPrice,
        "selectedProduct": selectedProduct,
      });
    } catch (err) {
      print(err);
    }
  }
}
