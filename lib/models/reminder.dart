// class for local caching data
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Reminder {
  final String note;
  final String bidId;
  Reminder({
    required this.note,
    required this.bidId,
  });

  Reminder copyWith({
    String? note,
    String? bidId,
  }) {
    return Reminder(
      note: note ?? this.note,
      bidId: bidId ?? this.bidId,
    );
  }

  @override
  String toString() => 'Reminder(note: $note, bidId: $bidId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reminder && other.note == note && other.bidId == bidId;
  }

  @override
  int get hashCode => note.hashCode ^ bidId.hashCode;
}
