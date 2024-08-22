class AppFormatter {

  static String formatPhoneNumber(String phoneNumber) {
    final RegExp regExp = RegExp(r'\D');
    String digitsOnly = phoneNumber.replaceAll(regExp, '');

    if (digitsOnly.startsWith('7')) {
      digitsOnly = digitsOnly.substring(1);
    }

    return digitsOnly;
  }
}