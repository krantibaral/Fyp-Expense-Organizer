
import 'package:intl/intl.dart';

class ReportFilter {
  // String type;
  DateTime? from;
  DateTime? to;
  ReportFilter({this.to, this.from});

  @override
  String toString() {
    var formatter = DateFormat(DateFormat.YEAR_MONTH_DAY);
    String toReturn = "From: ";
    if (from != null) {
      toReturn += formatter.format(from!);
    } else {
      toReturn += " null";
    }
    toReturn += ", to: ";
    if (to != null) {
      toReturn += formatter.format(to!);
    } else {
      toReturn += " null";
    }
    return toReturn;
  }
}