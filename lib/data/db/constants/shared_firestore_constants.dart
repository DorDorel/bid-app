import 'package:flutter/foundation.dart' show immutable;

@immutable
class SharedFirestoreConstants {
  static const sharedCollectionString = 'shared';
  static const bidConfigDocString = 'bidConfig';
  static const currentBidIdString = 'currentBidId';

  const SharedFirestoreConstants._();
}
