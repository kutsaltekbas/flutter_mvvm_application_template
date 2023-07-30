import 'package:easy_localization/easy_localization.dart';

String parseDateFormat(String date) {
  return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
}
