// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../model/Currency.dart';
import '../repository/currencies_repository.dart';
import '../widgets/home_currency_item.dart';
import '../widgets/selected_currency_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("CashOb", style: TextStyle(fontSize: 24)),
        actions: [
          GestureDetector(
              onTap: () {
                Modular.to.pushNamed("/select");
              },
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: SizedBox(height: 45, width: 45, child: Icon(Icons.help)),
              ))
        ],
      ),
      body: HomePageContent(),
    ));
  }
}

class HomePageContent extends StatefulWidget {
  CurrenciesRepository repo = CurrenciesRepository();
  HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  late Future<List<Currency>> currencies;
  late Future<Currency> selectedCurrency;

  @override
  void initState() {
    currencies = widget.repo.getCurrencies();
    selectedCurrency = widget.repo.getSelectedCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Modular.to.navigate("/select");
              },
              child: FutureBuilder<Currency>(
                future: selectedCurrency,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          padding: const EdgeInsets.all(2.0),
                          itemCount: 1,
                          itemBuilder: (context, i) {
                            return SelectedCurrency(
                                onClick: () {}, currency: snapshot.data!);
                            //onDelete, onEdit);
                          },
                        )
                      : Text('${snapshot.error}');
                },
              ),
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
    );
  }
}
