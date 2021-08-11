import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/core/utils/validation_utils.dart';

class DatesUtils {

   static String? convertToHumanDate(String? date) {
    String serverFormat = "";
    initializeDateFormatting(Intl.systemLocale, null);
    if (date != null && !ValidationUtils.isEmpty(date)) {
      try {
        DateTime dateTime = DateTime.parse(date);
        //Print.Debug("Datetime: "+dateTime.toLocal().toString() + " year: ${dateTime.year.toString()}"+ " month: ${dateTime.month.toString()}"+" date: ${dateTime.day.toString()}" + " hour: ${dateTime.hour.toString()}" +" minute: ${dateTime.minute.toString()}" + " second: ${dateTime.second.toString()}");

        //Print.Debug("${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()} ${dateTime.hour.toString()}-${dateTime.minute.toString()}-${dateTime.second.toString()}");
        serverFormat = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
        return serverFormat;
      } on FormatException catch (e) {
        Print.Debug(e.toString());
        return null;
      }
    }
    return null;
  }

   static String? convertToServerDate(String? date) {
     String serverFormat = "";
     initializeDateFormatting(Intl.systemLocale, null);
     if (date != null && !ValidationUtils.isEmpty(date)) {
      try {
        DateTime dateTime = DateTime.parse(date);
        //Print.Debug("Datetime: "+dateTime.toLocal().toString() + " year: ${dateTime.year.toString()}"+ " month: ${dateTime.month.toString()}"+" date: ${dateTime.day.toString()}" + " hour: ${dateTime.hour.toString()}" +" minute: ${dateTime.minute.toString()}" + " second: ${dateTime.second.toString()}");

        //Print.Debug("${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()} ${dateTime.hour.toString()}-${dateTime.minute.toString()}-${dateTime.second.toString()}");
        serverFormat = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
        return serverFormat;
      } on FormatException catch (e) {
        Print.Debug(e.toString());
        return null;
      }
     }
     return null;
   }

  // "EEE, MMM dd yyyy, hh:mm a"


  static String? formatDate(String? date, String? dateFormat) {
    String serverFormat = "";
    initializeDateFormatting(Intl.systemLocale, null);
    if (date != null && dateFormat != null && !ValidationUtils.isEmpty(date)) {
      try {
        DateTime dateTime = DateTime.parse(date);
        serverFormat = DateFormat(dateFormat).format(dateTime);
        return serverFormat;
      } on FormatException catch (e) {
        Print.Debug(e.toString());
        return null;
      }
    }
    return null;
  }
}