import 'package:cashob/app/Utils/colors.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12.withAlpha(10)),
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withAlpha(15),
            offset: const Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset(
                    'assets/flags/${widget.currency.code}.svg')),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.currency.name}',
                  style: const TextStyle(
                      color: CustomColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '${widget.currency.code}',
                  style: const TextStyle(
                      color: CustomColors.lightblack,
                      fontSize: 13,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          Expanded(
              child: Text(
            '${widget.currency.value}',
            style: const TextStyle(
                color: CustomColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w300),
          )),
        ],
      ),
    );
  }
}
