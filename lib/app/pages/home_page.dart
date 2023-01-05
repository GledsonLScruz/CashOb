// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../model/Currency.dart';
import '../repository/currencies_repository.dart';
import '../widgets/home_currency_item.dart';
import '../widgets/selected_currency_item.dart';
import '../widgets/selecting_currency_item.dart';

class HomePage extends StatelessWidget {
  final repo = Modular.get<CurrenciesRepository>();
  HomePage({super.key});

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
                Modular.to.pushNamed("/about");
              },
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: SizedBox(height: 45, width: 45, child: Icon(Icons.help)),
              ))
        ],
      ),
      body: HomePageContent(repo: repo),
    ));
  }
}

class HomePageContent extends StatefulWidget {
  CurrenciesRepository repo;
  HomePageContent({super.key, required this.repo});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  late Future<List<Currency>> currencies;
  late Future<String> selectedCurrency;

  @override
  void initState() {
    super.initState();
    currencies = widget.repo.getAllCurrencies();
    selectedCurrency = widget.repo.getSelectedCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 50,
            child: GestureDetector(
              onTap: () {
                Modular.to.navigate('/select');
              },
              child: FutureBuilder<String>(
                future: selectedCurrency,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? SelectedCurrency(currency: snapshot.data!)
                      : Text('${snapshot.error}');
                },
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder<List<Currency>>(
              future: currencies,
              builder: (context, snapshot) {
                return RefreshIndicator(
                    child: _listView(snapshot),
                    onRefresh: () async {
                      List<Currency> listCurrencies =
                          await widget.repo.getAllCurrencies();
                      setState(() {
                        currencies = Future.value(listCurrencies);
                      });
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _listView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        padding: const EdgeInsets.all(2.0),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return CurrencyItem(currency: snapshot.data![index]);
        },
      );
    } else {
      return const Center(
        child: Text('Loading data...'),
      );
    }
  }

  void _onButtonPressed(Future<List<Currency>> currencies) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return FutureBuilder<List<Currency>>(
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
                              await widget.repo.setSelectedCurrency(currency);
                              Future<List<Currency>> listCurrencies =
                                  widget.repo.getAllCurrencies();
                              setState(() {
                                currencies = listCurrencies;
                                selectedCurrency = Future.value(currency.code);
                              });
                            });
                      },
                    )
                  : Text('${snapshot.error}');
            },
          );
        });
  }
}
