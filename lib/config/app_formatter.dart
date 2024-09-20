import 'package:intl/intl.dart';

class AppFormatter {

  static String formatPhoneNumber(String phoneNumber) {
    final RegExp regExp = RegExp(r'\D');
    String digitsOnly = phoneNumber.replaceAll(regExp, '');

    if (digitsOnly.startsWith('7')) {
      digitsOnly = digitsOnly.substring(1);
    }

    return digitsOnly;
  }




  static String formatDateTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    String formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);

    return formattedDate;
  }
}