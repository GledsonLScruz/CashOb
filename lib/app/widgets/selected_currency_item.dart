import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/colors.dart';
import '../model/Currency.dart';

class SelectedCurrency extends StatefulWidget {
  final Currency currency;
  final Function onClick;
  const SelectedCurrency(
      {super.key, required this.currency, required this.onClick});

  @override
  State<SelectedCurrency> createState() => _SelectedCurrencyState();
}

class _SelectedCurrencyState extends State<SelectedCurrency> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 150,
          decoration: BoxDecoration(
            color: CustomColors.black,
            border: Border.all(color: CustomColors.lightblack, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: GestureDetector(
            onTap: () {
              widget.onClick();
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: SvgPicture.asset(
                        'assets/flags/${widget.currency.code ?? ''}.svg'),
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      child: Text(
                        '${widget.currency.code ?? ''}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: CustomColors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
