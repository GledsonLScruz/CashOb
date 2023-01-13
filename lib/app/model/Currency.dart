// ignore_for_file: constant_identifier_names
import '../utils/double_converter.dart';

class Currency {
  static const String TABLE = 'Currency';
  static const String COL_NAME = 'Name';
  static const String COL_CODE = 'Code';
  static const String COL_VALUE = 'Value';
  static const String COL_REF_CODE = 'ReferenceCode';

  String? _name;
  String? _code;
  double? _value;
  String? _refCode;

  // Getters
  String? get name => _name;
  String? get code => _code;
  double? get value => _value;
  String? get refCode => _refCode;

  // Setters
  set value(double? value) => {_value = value};

  // Map
  Currency.fromMap(dynamic obj) {
    _name = obj[COL_NAME];
    _code = obj[COL_CODE];
    _value = convertDouble(obj[COL_VALUE]);
    _refCode = obj[COL_REF_CODE];
  }

  Map<String, dynamic> toMap() {
    return {
      COL_NAME: _name,
      COL_CODE: _code,
      COL_VALUE: _value,
      COL_REF_CODE: _refCode
    };
  }

  Currency() {}

  Currency.fromApi(String name, String code, String refCode) {
    _code = code;
    _name = name;
    _refCode = refCode;
  }
}
