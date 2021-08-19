import 'dart:io';

import 'package:bid/db/tenant_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SharedDb {
  Future<int> getCurrentBidId() async {
    int curretnBidId = 0;

    final DocumentReference<Object?>? tenantRef =
        await TenantDB().getTenantReference();

    final CollectionReference<Map<String, dynamic>> sharedCollection =
        tenantRef!.collection('shared');

    final DocumentReference<Map<String, dynamic>> bidConfigDoc =
        sharedCollection.doc("bidConfig");

    final bidConfigDocObj = await bidConfigDoc.get();

    bidConfigDocObj.data()!.forEach((key, value) {
      if (key == "currentBidId") {
        curretnBidId = value;
      }
    });
    return curretnBidId;
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
