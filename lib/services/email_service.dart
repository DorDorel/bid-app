import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:url_launcher/url_launcher_string.dart';

@immutable
class EmailService {
  final String to;
  EmailService({required this.to});

  Future<void> sendBidInMail(
      String tenant, String tenantName, String bidDocId, String creator) async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    try {
      HttpsCallable callable = functions.httpsCallable('sendBidInEmail');
      await callable(
        {
          "clientMail": to,
          "tenantId": tenant,
          "tenantName": tenantName,
          "bidDocId": bidDocId,
          "creator": creator,
          // "ClientPhone": customerPhone,
        },
      );
    } catch (exp) {
      print(exp.toString());
    }
  }

  Future<void> openDefaultMainAppWithAddressClient() async {
    final _url = 'mailto:$to';
    if (!await launchUrlString(_url)) {
      throw 'Could not launch $_url';
    } else {
      await launchUrlString(_url);
    }
  }
}
