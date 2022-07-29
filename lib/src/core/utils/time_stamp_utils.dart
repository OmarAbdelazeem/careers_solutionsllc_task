import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimestampUtils {
  static String formatTimestamp(Timestamp timestamp) {
    return timeago.format(timestamp.toDate());
  }
}
