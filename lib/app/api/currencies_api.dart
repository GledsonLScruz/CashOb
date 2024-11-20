import 'package:dio/dio.dart';

import '../Utils/double_converter.dart';
import '../model/Currency.dart';

class ApiCurrency {
  static const api = 'https://api.frankfurter.app';

  Future<List<Currency>> getCurrencies(String selectedCurrency) async {
    List<Currency> listOfCurrencies = [];
    final currencies = await Dio().get('$api/currencies');
    final values = await Dio().get('$api/latest?from=$selectedCurrency');
    if (currencies.statusCode == 200 && values.statusCode == 200) {
      currencies.data.forEach((key, value) {
        listOfCurrencies.add(Currency.fromApi(convertString(value), convertString(key), selectedCurrency));
      });
      Map valuesmap = values.data["rates"];
      for (var currency in listOfCurrencies) {
        currency.value = convertDouble(valuesmap[currency.code]);
      }
      listOfCurrencies = listOfCurrencies.where((element) => element.value != null).toList();
    }
    return listOfCurrencies;
  }
}
