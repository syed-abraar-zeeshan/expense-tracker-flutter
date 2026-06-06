import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:expense_flow/core/storage/secure_storage_provider.dart';

part 'currency_controller.g.dart';

class CurrencyInfo {
  final String code;
  final String symbol;
  final String name;
  final double conversionRate; // Rate relative to base currency (e.g., INR)

  const CurrencyInfo({
    required this.code,
    required this.symbol,
    required this.name,
    required this.conversionRate,
  });
}

// Assuming base currency in database is INR (1.0)
// Rough exchange rates for demonstration purposes
const List<CurrencyInfo> availableCurrencies = [
  CurrencyInfo(
    code: 'INR',
    symbol: '₹',
    name: 'Indian Rupee',
    conversionRate: 1.0,
  ),
  CurrencyInfo(
    code: 'USD',
    symbol: '\$',
    name: 'US Dollar',
    conversionRate: 0.012,
  ), // 1 INR = ~0.012 USD
  CurrencyInfo(
    code: 'EUR',
    symbol: '€',
    name: 'Euro',
    conversionRate: 0.011,
  ), // 1 INR = ~0.011 EUR
  CurrencyInfo(
    code: 'GBP',
    symbol: '£',
    name: 'British Pound',
    conversionRate: 0.0094,
  ), // 1 INR = ~0.0094 GBP
];

@riverpod
class CurrencyController extends _$CurrencyController {
  static const _currencyKey = 'selected_currency_code';

  @override
  CurrencyInfo build() {
    _loadCurrency();
    return availableCurrencies.first; // Default to INR
  }

  Future<void> _loadCurrency() async {
    final storage = ref.read(secureStorageProvider);
    final code = await storage.read(_currencyKey);

    if (code != null) {
      state = availableCurrencies.firstWhere(
        (c) => c.code == code,
        orElse: () => availableCurrencies.first,
      );
    }
  }

  Future<void> setCurrency(CurrencyInfo currency) async {
    state = currency;
    final storage = ref.read(secureStorageProvider);
    await storage.write(_currencyKey, currency.code);
  }
}
