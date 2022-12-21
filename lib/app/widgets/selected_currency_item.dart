import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/Currency.dart';

class SelectedCurrency extends StatefulWidget {
  Currency currency;
  VoidCallback onClick;
  SelectedCurrency({super.key, required this.currency, required this.onClick});

  @override
  State<SelectedCurrency> createState() => _SelectedCurrencyState();
}

class _SelectedCurrencyState extends State<SelectedCurrency> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClick();
      },
      child: Row(
        children: [Text(widget.currency.name!), Text(widget.currency.code!)],
      ),
    );
  }
}
