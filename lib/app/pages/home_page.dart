// ignore_for_file: must_be_immutable
import 'package:cashob/app/Utils/colors.dart';
import 'package:cashob/app/Utils/custom_transition.dart';
import 'package:cashob/app/pages/converter_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../model/Currency.dart';
import '../repository/currencies_repository.dart';
import '../widgets/list_currency_home.dart';
import '../widgets/selected_currency_item.dart';
import '../widgets/selecting_currency_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "CashOb",
              style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: const HomePageContent(),
    ));
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  late List<Currency> currencies;
  late Currency selectedCurrency;
  late CurrenciesRepository repo;

  @override
  void initState() {
    context.read<CurrenciesRepository>().fetchCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    repo = context.watch<CurrenciesRepository>();
    currencies = repo.currencies;
    selectedCurrency = repo.selectedCurrency;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Divider(),
          SelectedCurrency(
              currency: selectedCurrency,
              onClick: () {
                _onButtonPressed(context, currencies, repo);
              }),
          const SizedBox(
            height: 10,
          ),
          const Labels(),
          const Divider(),
          ListOfCurrencies(
            currencies: currencies,
            onClick: (currency) {
              Navigator.of(context).push(createRoute(ConverterPage(
                  currency1: selectedCurrency, currency2: currency)));
            },
            onSwipeDown: () {
              repo.fetchCurrencies();
            },
          )
        ],
      ),
    );
  }
}

class Labels extends StatelessWidget {
  const Labels({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Expanded(
              child: Text(
            'Flag',
            style: TextStyle(
                color: CustomColors.lightblack,
                fontSize: 14,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          )),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Name and Acronym',
                  style: TextStyle(
                      color: CustomColors.lightblack,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const Expanded(
              child: Text(
            'Value',
            style: TextStyle(
                color: CustomColors.lightblack,
                fontSize: 14,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}

void _onButtonPressed(BuildContext context, List<Currency> currencies,
    CurrenciesRepository repo) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int moeda) {
              return CurrencyToSelect(
                currency: currencies[moeda],
                onClick: (currency) {
                  repo.setnewcurrencie(currency);
                  Navigator.pop(context);
                },
              );
            },
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, ___) => const Divider(),
            itemCount: currencies.length,
          ),
        );
      });
}
