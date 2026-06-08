import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:expense_flow/features/settings/data/services/currency_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:expense_flow/core/storage/secure_storage_provider.dart';

part 'currency_controller.g.dart';

class CurrencyInfo {
  final String code;
  final String symbol;
  final String name;
  final double conversionRate;

  const CurrencyInfo({
    required this.code,
    required this.symbol,
    required this.name,
    this.conversionRate = 1.0,
  });

  CurrencyInfo copyWith({double? conversionRate}) {
    return CurrencyInfo(
      code: code,
      symbol: symbol,
      name: name,
      conversionRate: conversionRate ?? this.conversionRate,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'symbol': symbol,
        'name': name,
        'conversionRate': conversionRate,
      };

  factory CurrencyInfo.fromJson(Map<String, dynamic> json) => CurrencyInfo(
        code: json['code'],
        symbol: json['symbol'],
        name: json['name'],
        conversionRate: (json['conversionRate'] as num).toDouble(),
      );
}

final List<CurrencyInfo> _initialCurrencies = [
  const CurrencyInfo(code: 'INR', symbol: '₹', name: 'Indian Rupee'),
  const CurrencyInfo(code: 'USD', symbol: '\$', name: 'US Dollar'),
  const CurrencyInfo(code: 'EUR', symbol: '€', name: 'Euro'),
  const CurrencyInfo(code: 'GBP', symbol: '£', name: 'British Pound'),
  const CurrencyInfo(code: 'JPY', symbol: '¥', name: 'Japanese Yen'),
  const CurrencyInfo(code: 'AUD', symbol: 'A\$', name: 'Australian Dollar'),
  const CurrencyInfo(code: 'CAD', symbol: 'C\$', name: 'Canadian Dollar'),
  const CurrencyInfo(code: 'CHF', symbol: 'CHF', name: 'Swiss Franc'),
  const CurrencyInfo(code: 'CNY', symbol: '元', name: 'Chinese Yuan'),
  const CurrencyInfo(code: 'HKD', symbol: 'HK\$', name: 'Hong Kong Dollar'),
  const CurrencyInfo(code: 'NZD', symbol: 'NZ\$', name: 'New Zealand Dollar'),
  const CurrencyInfo(code: 'SGD', symbol: 'S\$', name: 'Singapore Dollar'),
  const CurrencyInfo(code: 'AED', symbol: 'د.إ', name: 'UAE Dirham'),
  const CurrencyInfo(code: 'SAR', symbol: '﷼', name: 'Saudi Riyal'),
  const CurrencyInfo(code: 'KWD', symbol: 'د.ك', name: 'Kuwaiti Dinar'),
  const CurrencyInfo(code: 'BHD', symbol: '.د.ب', name: 'Bahraini Dinar'),
  const CurrencyInfo(code: 'OMR', symbol: '﷼', name: 'Omani Rial'),
  const CurrencyInfo(code: 'QAR', symbol: '﷼', name: 'Qatari Rial'),
  const CurrencyInfo(code: 'THB', symbol: '฿', name: 'Thai Baht'),
  const CurrencyInfo(code: 'MYR', symbol: 'RM', name: 'Malaysian Ringgit'),
  const CurrencyInfo(code: 'IDR', symbol: 'Rp', name: 'Indonesian Rupiah'),
  const CurrencyInfo(code: 'PHP', symbol: '₱', name: 'Philippine Peso'),
  const CurrencyInfo(code: 'VND', symbol: '₫', name: 'Vietnamese Dong'),
  const CurrencyInfo(code: 'KRW', symbol: '₩', name: 'South Korean Won'),
  const CurrencyInfo(code: 'TRY', symbol: '₺', name: 'Turkish Lira'),
  const CurrencyInfo(code: 'RUB', symbol: '₽', name: 'Russian Ruble'),
  const CurrencyInfo(code: 'BRL', symbol: 'R\$', name: 'Brazilian Real'),
  const CurrencyInfo(code: 'ZAR', symbol: 'R', name: 'South African Rand'),
];

class CurrencyState {
  final CurrencyInfo selectedCurrency;
  final List<CurrencyInfo> availableCurrencies;
  final bool isSyncing;

  const CurrencyState({
    required this.selectedCurrency,
    required this.availableCurrencies,
    this.isSyncing = false,
  });

  CurrencyState copyWith({
    CurrencyInfo? selectedCurrency,
    List<CurrencyInfo>? availableCurrencies,
    bool? isSyncing,
  }) {
    return CurrencyState(
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      availableCurrencies: availableCurrencies ?? this.availableCurrencies,
      isSyncing: isSyncing ?? this.isSyncing,
    );
  }
}

@riverpod
class CurrencyController extends _$CurrencyController {
  static const _selectedCodeKey = 'selected_currency_code';
  static const _ratesKey = 'cached_currency_rates';
  static const _lastSyncKey = 'last_currency_sync_time';

  @override
  CurrencyState build() {
    _init();
    return CurrencyState(
      selectedCurrency: _initialCurrencies.first,
      availableCurrencies: _initialCurrencies,
    );
  }

  Future<void> _init() async {
    final storage = ref.read(secureStorageProvider);
    
    // 1. Load cached rates
    List<CurrencyInfo> currentList = _initialCurrencies;
    final cachedRatesJson = await storage.read(_ratesKey);
    if (cachedRatesJson != null) {
      try {
        final Map<String, dynamic> rates = jsonDecode(cachedRatesJson);
        currentList = _initialCurrencies.map((c) {
          return c.copyWith(conversionRate: rates[c.code] ?? 1.0);
        }).toList();
      } catch (_) {}
    }

    if (!ref.mounted) return;

    // 2. Load selected currency
    final code = await storage.read(_selectedCodeKey);
    final selected = currentList.firstWhere(
      (c) => c.code == code,
      orElse: () => currentList.first,
    );

    state = state.copyWith(
      selectedCurrency: selected,
      availableCurrencies: currentList,
    );

    // 3. Background sync if needed
    _backgroundSync();
  }

  Future<void> _backgroundSync() async {
    final storage = ref.read(secureStorageProvider);
    final lastSyncStr = await storage.read(_lastSyncKey);
    final lastSync = lastSyncStr != null ? DateTime.parse(lastSyncStr) : null;

    // Sync only if more than 6 hours old
    if (lastSync == null || DateTime.now().difference(lastSync).inHours > 6) {
      state = state.copyWith(isSyncing: true);
      try {
        final service = CurrencyService(Dio());
        final rates = await service.fetchLatestRates();
        
        if (!ref.mounted) return;

        final updatedList = _initialCurrencies.map((c) {
          return c.copyWith(conversionRate: rates[c.code] ?? 1.0);
        }).toList();

        final updatedSelected = updatedList.firstWhere(
          (c) => c.code == state.selectedCurrency.code,
          orElse: () => updatedList.first,
        );

        state = state.copyWith(
          selectedCurrency: updatedSelected,
          availableCurrencies: updatedList,
          isSyncing: false,
        );

        // Save to storage
        await storage.write(_ratesKey, jsonEncode(rates));
        await storage.write(_lastSyncKey, DateTime.now().toIso8601String());
      } catch (e) {
        if (ref.mounted) {
          state = state.copyWith(isSyncing: false);
        }
      }
    }
  }

  Future<void> setCurrency(CurrencyInfo currency) async {
    state = state.copyWith(selectedCurrency: currency);
    final storage = ref.read(secureStorageProvider);
    await storage.write(_selectedCodeKey, currency.code);
  }
}
