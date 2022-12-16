import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/Currency.dart';

import 'package:http/http.dart' as http;

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  Future<List<Currency>> currencies = fetchCurrencies();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Currency>>(
          future: currencies,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    padding: const EdgeInsets.all(2.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return cur(currency: snapshot.data![i]);
                      //onDelete, onEdit);
                    },
                  )
                : Text('${snapshot.error}');
          },
        ),
      ),
    );
  }
}

Future<List<Currency>> fetchCurrencies() async {
  const apiHost = 'https://api.frankfurter.app';
  final currencies = await http.get(Uri.parse('$apiHost/currencies'));

  if (currencies.statusCode == 200) {
    List<Currency> listOfCurrencies = [];
    jsonDecode(currencies.body).forEach((key, value) {
      listOfCurrencies.add(Currency.fromApi(value.toString(), key.toString()));
    });
    return listOfCurrencies;
  } else {
    throw Exception('Failed to load album');
  }
}

class cur extends StatelessWidget {
  Currency currency;
  cur({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(currency.code!),
        Text(currency.name!),
      ],
    );
  }
}
