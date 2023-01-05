import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/double_converter.dart';
import '../model/Currency.dart';

class ApiCurrency {
  static const api = 'https://api.frankfurter.app';

  Future<List<Currency>> getCurrencies(String selectedCurrency) async {
    List<Currency> listOfCurrencies = [];
    final currencies = await http.get(Uri.parse('$api/currencies'));
    final values =
        await http.get(Uri.parse('$api/latest?from=$selectedCurrency'));

    if (currencies.statusCode == 200 && values.statusCode == 200) {
      jsonDecode(currencies.body).forEach((key, value) {
        listOfCurrencies.add(Currency.fromApi(
            value.toString(), key.toString(), selectedCurrency));
      });
      Map valuesmap = jsonDecode(values.body)["rates"];
      for (var currency in listOfCurrencies) {
        currency.value = convertDouble(valuesmap[currency.code]);
      }

      return listOfCurrencies
          .where((element) => element.value != null)
          .toList();
    } else {
      throw Exception('Failed to get Currencies From API');
    }
  }
}
