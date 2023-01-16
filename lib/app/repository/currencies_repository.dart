import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/currencies_api.dart';
import '../model/Currency.dart';
import '../sqlite/currency_helper.dart';

class CurrenciesRepository extends ChangeNotifier {
  List<Currency> _currencies = [];
  Currency _selectedCurrency = Currency();
  final ApiCurrency _apiCurrency = ApiCurrency();
  final CurrencyHelper _dbCurrency = CurrencyHelper();

  List<Currency> get currencies => _currencies;
  Currency get selectedCurrency => _selectedCurrency;

  fetchCurrencies() async {
    if (_currencies.length > 0) {
      _currencies.clear();
      notifyListeners();
    }

    final prefs = await SharedPreferences.getInstance();
    final selectedCurrencyCode = prefs.getString('code') ?? 'BRL';
    final selectedCurrencyName = prefs.getString('name') ?? 'Brazilian Real';

    List<Currency> currencies =
        await _apiCurrency.getCurrencies(selectedCurrencyCode);

    await _dbCurrency.insertList(currencies);

    _selectedCurrency =
        Currency.fromApi(selectedCurrencyName, selectedCurrencyCode, '');
    _currencies = await _dbCurrency.list(selectedCurrencyCode);

    notifyListeners();
  }

  setnewcurrencie(Currency currency) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('code', currency.code!);
    prefs.setString('name', currency.name!);
    _selectedCurrency = currency;
    fetchCurrencies();
  }
}
