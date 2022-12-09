import 'package:flutter/rendering.dart';

class Currency {
  late String _name;
  late String _code;
  double _value = 0.0;

  Currency({required String name, required String code}) {
    _name = name;
    _code = code;
  }

  void setValue(double newValue) {
    _value = newValue;
  }

  double getValue() {
    return _value;
  }

  String getName() {
    return _name;
  }

  String getCode() {
    return _code;
  }

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: "",
      code: "",
      //userId: json['userId'],
      //id: json['id'],
      //title: json['title'],
    );
  }
}
