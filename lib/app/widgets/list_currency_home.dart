import 'package:cashob/app/widgets/home_currency_item.dart';
import 'package:cashob/app/widgets/selecting_currency_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/Currency.dart';

typedef void CallBackFunction(currency);

class ListOfCurrencies extends StatelessWidget {
  final List<Currency> currencies;
  final CallBackFunction onClick;
  final Function onSwipeDown;
  const ListOfCurrencies(
      {super.key,
      required this.currencies,
      required this.onClick,
      required this.onSwipeDown});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: RefreshIndicator(
          onRefresh: () async {
            onSwipeDown();
          },
          child: currencies.isEmpty
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
                        onTap: () => onClick(currencies[moeda]),
                        child: CurrencyItem(currency: currencies[moeda]));
                  },
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  itemCount: currencies.length,
                )),
    );
  }
}
