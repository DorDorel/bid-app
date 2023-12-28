import 'dart:developer';

import 'package:bid/services/email_service.dart';
import 'package:flutter/cupertino.dart';

@immutable
class BidFlowRunner {
  final String tenantId;
  final String tenantName;
  final String bidDocId;
  final String customerEmail;
  final String customerPhone;
  final String creator;
  BidFlowRunner({
    required this.tenantId,
    required this.tenantName,
    required this.bidDocId,
    required this.customerEmail,
    required this.customerPhone,
    required this.creator,
  });

  Future<void> runner() async {
    try {
      final EmailService emailService = EmailService(
        to: customerEmail,
      );
      emailService.sendBidInMail(
        tenantId,
        tenantName,
        bidDocId,
        creator,
      );
    } catch (err) {
      log(
        err.toString(),
      );
    }
  }
}
