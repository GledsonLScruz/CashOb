// ignore_for_file: constant_identifier_names

class Currency {
  static const String TABLE = 'Currency';
  static const String COL_ID = 'Id';
  static const String COL_NAME = 'Name';
  static const String COL_CODE = 'Code';
  static const String COL_VALUE = 'Value';

  int? _id;
  String? _name;
  String? _code;
  double? _value;

  Currency(this._name, this._code);

  // Getters
  int? get id => _id;
  String? get name => _name;
  String? get code => _code;
  double? get value => _value;

  // Setters
  set name(String? name) => {_name = name};
  set code(String? code) => {_code = code};
  set value(double? value) => {_value = value};

  // Map
  Currency.fromMap(dynamic obj) {
    _id = obj[COL_ID];
    _name = obj[COL_NAME];
    _code = obj[COL_CODE];
    _value = obj[COL_VALUE];
  }

  Map<String, dynamic> toMap() {
    return {COL_ID: _id, COL_NAME: _name, COL_CODE: _code, COL_VALUE: _value};
  }

  Currency.fromApi(String name, String code) {
    _code = code;
    _name = name;
  }
}
