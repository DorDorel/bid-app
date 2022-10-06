import 'package:flutter/foundation.dart' show immutable;
import 'package:url_launcher/url_launcher_string.dart';

@immutable
class CallService {
  final String phoneNumber;
  CallService({required this.phoneNumber});

  Future<void> callNow() async {
    final tel = 'tel$phoneNumber';
    if (!await launchUrlString(tel)) {
      throw 'Could not launch $tel';
    } else {
      launchUrlString(tel);
    }
  }
}
