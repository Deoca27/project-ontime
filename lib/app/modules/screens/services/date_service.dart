import 'package:intl/intl.dart';

class DateService {
  static String getFormattedDate() {
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());
  }
}