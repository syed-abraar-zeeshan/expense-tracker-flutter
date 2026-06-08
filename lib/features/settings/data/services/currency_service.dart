import 'package:dio/dio.dart';

class CurrencyService {
  final Dio _dio;

  CurrencyService(this._dio);

  Future<Map<String, double>> fetchLatestRates() async {
    try {
      // Using a reliable public API from ExchangeRate-API
      final response = await _dio.get('https://open.er-api.com/v6/latest/INR');
      
      if (response.statusCode == 200) {
        final rates = response.data['rates'] as Map<String, dynamic>;
        return rates.map((key, value) => MapEntry(key, (value as num).toDouble()));
      } else {
        throw Exception('Failed to load currency rates');
      }
    } catch (e) {
      throw Exception('Error fetching currency rates: $e');
    }
  }
}
