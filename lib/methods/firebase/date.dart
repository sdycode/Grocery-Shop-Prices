import 'package:intl/intl.dart';

extension Under on DateTime {
  String dateToUnder_Score_String() {
    final DateFormat formatter = DateFormat('dd_MM_yyyy');
    return formatter.format(this);
  }
}

extension UnderString on String {
  DateTime dateStringTo_DateTime() {
    final DateFormat formatter = DateFormat('dd_MM_yyyy');
    return formatter.parse(this);
  }
}
