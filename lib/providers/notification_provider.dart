import 'package:bid/models/bid.dart';
import 'package:flutter/foundation.dart';

class NotificationProvider extends ChangeNotifier {
  List<Bid> _relevantNotificationBid = [];
  List<Bid> get getRelevantNotificationBid => _relevantNotificationBid;
}
