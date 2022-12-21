import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Utils/double_converter.dart';
import '../model/Currency.dart';

class ApiCurrency {
  static const api = 'https://api.frankfurter.app';

  Future<List<Currency>> getcurrencies(String selectedCurrency) async {
    final currencies = await http.get(Uri.parse('$api/currencies'));
    final values =
        await http.get(Uri.parse('$api/latest?from=$selectedCurrency'));

    if (currencies.statusCode == 200 && values.statusCode == 200) {
      List<Currency> listOfCurrencies = [];
      jsonDecode(currencies.body).forEach((key, value) {
        listOfCurrencies
            .add(Currency.fromApi(value.toString(), key.toString()));
      });
      Map valuesmap = jsonDecode(values.body)["rates"];

      listOfCurrencies.forEach((currency) {
        if (valuesmap[currency.code] == null) {
          currency.value = -1.0;
        } else {
          currency.value = convertDouble(valuesmap[currency.code]);
        }
      });

      return listOfCurrencies
          .where((element) => element.value != -1.0)
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Currency>> getCurrenciesToSelect() async {
    final currencies = await http.get(Uri.parse('$api/currencies'));

    if (currencies.statusCode == 200) {
      List<Currency> listOfCurrencies = [];
      jsonDecode(currencies.body).forEach((key, value) {
        listOfCurrencies
            .add(Currency.fromApi(value.toString(), key.toString()));
      });

      return listOfCurrencies;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
