import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/Currency.dart';

class CurrencyItem extends StatefulWidget {
  Currency currency;
  CurrencyItem({super.key, required this.currency});

  @override
  State<CurrencyItem> createState() => _CurrencyItemState();
}

class _CurrencyItemState extends State<CurrencyItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withAlpha(10),
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset(
                    'assets/flags/${widget.currency.code}.svg')),
            SizedBox(
              width: 15,
            ),
            Row(
              children: [
                Text(
                  '${widget.currency.name}',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                Text(
                  ' - ${widget.currency.code}',
                  style: TextStyle(color: Colors.black38),
                )
              ],
            ),
            SizedBox(
              width: 35,
            ),
            Text('${widget.currency.value}'),
          ],
        ),
      ),
    );
  }
}
