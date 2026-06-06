import 'package:intl/intl.dart';

class AppCurrencyFormatter {
  AppCurrencyFormatter._();

  static String format(
    double amount, {
    String symbol = '₹',
    double conversionRate = 1.0,
  }) {
    final convertedAmount = amount * conversionRate;
    
    // Determine decimal digits dynamically based on currency scale
    // e.g. USD typically shows 2 decimals, INR usually shows 0 for whole numbers
    final decimals = (conversionRate < 1.0) ? 2 : 0;

    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimals,
    );
    return formatter.format(convertedAmount);
  }
}

