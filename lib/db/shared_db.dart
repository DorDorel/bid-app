import 'dart:html';

import 'package:bid/db/tenant_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SharedDb {
  Future<dynamic> getCurrentBidId() async {
    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();

    final CollectionReference<Map<String, dynamic>> sharedCollection =
        tenantRef!.collection('shared');

    Future<DocumentSnapshot<Map<String, dynamic>>> bidConfigDoc =
        sharedCollection.doc("bidConfig").snapshots().first;

    print(bidConfigDoc);
    return bidConfigDoc;
  }
}
