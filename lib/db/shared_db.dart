import 'package:bid/db/tenant_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SharedDb {
  static Future<int> getCurrentBidId() async {
    int currentBidId = 0;

    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();

    final CollectionReference<Map<String, dynamic>> sharedCollection =
        tenantRef!.collection('shared');

    final DocumentReference<Map<String, dynamic>> bidConfigDoc =
        sharedCollection.doc("bidConfig");

    final bidConfigDocObj = await bidConfigDoc.get();

    bidConfigDocObj.data()!.forEach((key, value) {
      if (key == "currentBidId") {
        currentBidId = value;
      }
    });
    return currentBidId;
  }

  Future<bool> updateBidId() async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();

    final CollectionReference<Map<String, dynamic>> sharedCollection =
        tenantRef!.collection('shared');

    final DocumentReference<Map<String, dynamic>> bidConfigDoc =
        sharedCollection.doc("bidConfig");

    try {
      Map<String, int> updated = {"currentBidId": await getCurrentBidId() + 1};
      bidConfigDoc.update(updated);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
