import 'package:cashob/app/widgets/home_currency_item.dart';
import 'package:cashob/app/widgets/selecting_currency_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/Currency.dart';

class ListOfCurrencies extends StatefulWidget {
  List<Currency> currencies;
  Function(Currency) onClick;
  ListOfCurrencies(
      {super.key, required this.currencies, required this.onClick});

  @override
  State<ListOfCurrencies> createState() => _ListOfCurrenciesState();
}

class _ListOfCurrenciesState extends State<ListOfCurrencies> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: RefreshIndicator(
          onRefresh: () async {},
          child: widget.currencies.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 12,
                  ),
                  itemBuilder: (BuildContext context, int moeda) {
                    return GestureDetector(
                        onTap: () {
                          widget.onClick(widget.currencies[moeda]);
                        },
                        child:
                            CurrencyItem(currency: widget.currencies[moeda]));
                  },
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  itemCount: widget.currencies.length,
                )),
    );
  }
}
