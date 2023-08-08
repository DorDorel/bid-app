import 'package:flutter/foundation.dart' show kDebugMode;

extension IfDebuggingString on String {
  String? get ifDebuggingString => kDebugMode ? this : null;
}

extension IfDebuggingBool on bool {
  bool get ifDebuggingBool => kDebugMode ? true : false;
}
