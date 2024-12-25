
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../auth/tenant_repository.dart';
import 'constants/shared_firestore_constants.dart';

@immutable
class SharedDb {
  static Future<int> getCurrentBidId() async {
    int currentBidId = 0;

    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();

    final CollectionReference<Map<String, dynamic>> sharedCollection =
        tenantRef!.collection(
      SharedFirestoreConstants.sharedCollectionString,
    );

    final DocumentReference<Map<String, dynamic>> bidConfigDoc =
        sharedCollection.doc(
      SharedFirestoreConstants.bidConfigDocString,
    );

    final bidConfigDocObj = await bidConfigDoc.get();

    bidConfigDocObj.data()!.forEach(
      (key, value) {
        if (key == SharedFirestoreConstants.currentBidIdString) {
          currentBidId = value;
        }
      },
    );
    return currentBidId;
  }

  Future<bool> updateBidId() async {
    final DocumentReference<Object?>? tenantRef =
        await TenantRepositoryImpl().getTenantReference();

    final CollectionReference<Map<String, dynamic>> sharedCollection =
        tenantRef!.collection(
      SharedFirestoreConstants.sharedCollectionString,
    );

    final DocumentReference<Map<String, dynamic>> bidConfigDoc =
        sharedCollection.doc(
      SharedFirestoreConstants.bidConfigDocString,
    );

    try {
      Map<String, int> updated = {
        SharedFirestoreConstants.currentBidIdString:
            await getCurrentBidId() + 1,
      };
      bidConfigDoc.update(
        updated,
      );
      return true;
    } catch (exp) {
      print(exp.toString());
      return false;
    }
  }
}
