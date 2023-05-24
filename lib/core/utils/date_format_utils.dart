import 'package:intl/intl.dart';

abstract class DateFormatUtils {
  static final DateFormat standard = DateFormat("MMM dd, yyyy");

  static final DateFormat standardWithTime = DateFormat("MMM dd, yyyy | HH:mm");
}