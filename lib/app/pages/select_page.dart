import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Currency.dart';
import '../repository/currencies_repository.dart';
import '../widgets/selecting_currency_item.dart';

class SelectPage extends StatefulWidget {
  CurrenciesRepository repo = CurrenciesRepository();
  SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  late Future<List<Currency>> currencies;

  @override
  void initState() {
    currencies = widget.repo.getCurrenciesToSelect();
    super.initState();
  }

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
                      return CurrencyToSelect(
                          currency: snapshot.data![i],
                          onClick: (currency) async {
                            setState(() async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  'selectedCurrency', '${currency.code}');
                              Modular.to.pop();
                            });
                          });
                    },
                  )
                : Text('${snapshot.error}');
          },
        ),
      ),
    );
  }
}
