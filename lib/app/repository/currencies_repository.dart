import 'package:shared_preferences/shared_preferences.dart';

import '../api/currencies_api.dart';
import '../model/Currency.dart';
import '../sqlite/currency_helper.dart';

class CurrenciesRepository {
  ApiCurrency apiCurrency = ApiCurrency();
  CurrencyHelper dbCurrency = CurrencyHelper();

  Future<List<Currency>> getCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('selectedCurrency');
    List<Currency> listOfCurrencies = await apiCurrency.getcurrencies(code!);
    return listOfCurrencies;
  }

  Future<List<Currency>> getCurrenciesToSelect() async {
    List<Currency> listOfCurrencies = await apiCurrency.getCurrenciesToSelect();
    return listOfCurrencies;
  }

  Future<Currency> getSelectedCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('selectedCurrency');
    //TODO: DB
    Currency currency = Currency("chama", code);
    return currency;
  }

  Future<void> changeSelectedCurrency(Currency currency) async {
    //TODO: DB
  }
}
