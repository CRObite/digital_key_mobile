class CurrencySymbol{
  static String getCurrencySymbol(String code) {
    final Map<String, String> symbols = {
      'USD': '\$',  // Dollar symbol
      'EUR': '€',   // Euro symbol
      'RUB': '₽',   // Russian Ruble symbol
      'KZT': '₸',   // Kazakhstani Tenge symbol
    };

    // Convert the code to uppercase
    String upperCaseCurrencyName = code.toUpperCase();

    // Check if the symbol exists in the map and return the corresponding symbol
    if (symbols.containsKey(upperCaseCurrencyName)) {
      return symbols[upperCaseCurrencyName]!;
    } else {
      return '';
    }
  }
}