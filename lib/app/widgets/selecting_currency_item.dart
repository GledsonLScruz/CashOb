import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/Currency.dart';

class CurrencyToSelect extends StatelessWidget {
  Currency currency;
  Function(Currency) onClick;
  CurrencyToSelect({super.key, required this.currency, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(currency),
      child: Text("${currency.code} + ${currency.name}"),
    );
  }
}
