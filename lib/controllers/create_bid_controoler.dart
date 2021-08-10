import 'package:bid/models/bid.dart';

class CreateBidController {
  final Bid currentBid;

  CreateBidController(this.currentBid);

  Future<bool> createBidFile() async {
    try {
      return true;
    } catch (err) {
      return false;
    }
  }
}
