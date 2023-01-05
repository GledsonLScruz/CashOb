import 'package:shared_preferences/shared_preferences.dart';

import '../api/currencies_api.dart';
import '../model/Currency.dart';
import '../sqlite/currency_helper.dart';

class CurrenciesRepository {
  ApiCurrency apiCurrency = ApiCurrency();
  CurrencyHelper dbCurrency = CurrencyHelper();

  Future<List<Currency>> getAllCurrencies() async {
    return await getCurrenciesFromAPI();
  }

  Future<String> getSelectedCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    String currencyCode = prefs.getString('selectedCurrency')!;
    return currencyCode;
  }

  Future<void> setSelectedCurrency(Currency currency) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedCurrency', currency.code!);
  }

  Future<List<Currency>> getCurrenciesFromAPI() async {
    final prefs = await SharedPreferences.getInstance();
    String selectedCurrency = prefs.getString('selectedCurrency')!;
    List<Currency> currencies =
        await apiCurrency.getCurrencies(selectedCurrency);
    dbCurrency.insertList(currencies);
    return currencies;
  }
}
