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
    String formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(dateTime);

    return formattedDate;
  }



  String formatCurrency(double amount,String symbol,int decimalDigits) {

    final NumberFormat formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: symbol,
      decimalDigits: decimalDigits,
    );

    String formatted = formatter.format(amount).replaceAll(',', ' ');
    return formatted;
  }
}