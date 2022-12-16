import 'dart:convert';

import 'package:cashob/model/Currency.dart';
import 'package:cashob/pages/select_page.dart';
import 'package:cashob/widgets/currency_item.dart';
import 'package:cashob/widgets/selected_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Currency>> currencies = fetchCurrencies();
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: FutureBuilder<List<Currency>>(
                future: currencies,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          padding: const EdgeInsets.all(2.0),
                          itemCount: 1,
                          itemBuilder: (context, i) {
                            return SelectedCurrency(
                              currency: snapshot.data!
                                  .where((element) => element.value == -1.0)
                                  .first,
                              onClick: () {
                                Modular.to.navigate("/select");
                              },
                            );
                          },
                        )
                      : Text('${snapshot.error}');
                },
              ),
            ),
            Flexible(
              child: FutureBuilder<List<Currency>>(
                future: currencies,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          padding: const EdgeInsets.all(2.0),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return CurrencyItem(currency: snapshot.data![i]);
                            //onDelete, onEdit);
                          },
                        )
                      : Text('${snapshot.error}');
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Future<List<Currency>> fetchCurrencies() async {
  const apiHost = 'https://api.frankfurter.app';
  final currencies = await http.get(Uri.parse('$apiHost/currencies'));
  final values = await http.get(Uri.parse('$apiHost/latest?from=BRL'));

  if (currencies.statusCode == 200 && values.statusCode == 200) {
    List<Currency> listOfCurrencies = [];
    jsonDecode(currencies.body).forEach((key, value) {
      listOfCurrencies.add(Currency.fromApi(value.toString(), key.toString()));
    });

    Map a = jsonDecode(currencies.body).toList();

    Map valuesmap = jsonDecode(values.body)["rates"];

    listOfCurrencies.forEach((currency) {
      if (valuesmap[currency.code] == null) {
        currency.value = -1.0;
      } else {
        convertDouble(valuesmap[currency.code]);
      }
    });

    return listOfCurrencies;
  } else {
    throw Exception('Failed to load album');
  }
}

double convertDouble(dynamic e) {
  dynamic result;
  if (e != null) {
    if (e is String) {
      result = double.parse(e);
    } else if (e is int) {
      result = e.toDouble();
    } else if (e is double) {
      result = e;
    }
  }
  return result;
}
