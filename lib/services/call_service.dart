import 'package:url_launcher/url_launcher.dart';

class CallService {
  final phoneNumber;
  CallService({required this.phoneNumber});

  Future<void> callNow() async {
    final _tel = 'tel$phoneNumber';
    if (!await launch(_tel)) {
      throw 'Could not launch $_tel';
    } else {
      launch(_tel);
    }
  }
}
