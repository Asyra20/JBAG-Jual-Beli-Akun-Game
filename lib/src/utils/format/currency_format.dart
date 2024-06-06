import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convert2Idr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );

    return currencyFormatter.format(number);
  }
}
