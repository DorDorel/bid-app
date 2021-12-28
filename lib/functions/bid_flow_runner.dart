import 'package:bid/services/email_service.dart';

class BidFlowRunner {
  String tenantId;
  String bidDocId;
  String customerEmail;
  String customerPhone;
  String creator;
  BidFlowRunner(
      {required this.tenantId,
      required this.bidDocId,
      required this.customerEmail,
      required this.customerPhone,
      required this.creator});

  Future<void> runner() async {
    try {
      final EmailService es = new EmailService(to: customerEmail);
      es.sendBidInMail(tenantId, bidDocId, creator);
    } catch (err) {
      print(err);
    }
  }
}
