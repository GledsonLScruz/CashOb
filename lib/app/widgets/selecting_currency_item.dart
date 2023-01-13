import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../Utils/colors.dart';
import '../model/Currency.dart';

class CurrencyToSelect extends StatelessWidget {
  Currency currency;
  Function(Currency) onClick;
  CurrencyToSelect({super.key, required this.currency, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick(currency);
      },
      child: Container(
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
                  child: SvgPicture.asset('assets/flags/${currency.code}.svg')),
            ),
            Expanded(
              child: Text(
                '${currency.code}',
                style: const TextStyle(
                    color: CustomColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
