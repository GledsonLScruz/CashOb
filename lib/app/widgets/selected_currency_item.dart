import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/Currency.dart';

class SelectedCurrency extends StatefulWidget {
  String currency;
  SelectedCurrency({super.key, required this.currency});

  @override
  State<SelectedCurrency> createState() => _SelectedCurrencyState();
}

class _SelectedCurrencyState extends State<SelectedCurrency> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(widget.currency)],
    );
  }
}
