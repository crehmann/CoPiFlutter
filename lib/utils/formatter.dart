import 'dart:math';
import 'package:intl/intl.dart';

final _longDateTimeFormat = new DateFormat.yMd().add_jm();

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 bytes";
  const suffixes = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
}

String formatLongDateTime(DateTime dateTime) {
  return _longDateTimeFormat.format(dateTime);
}
