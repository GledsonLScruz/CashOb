double? convertDouble(dynamic e) {
  dynamic result;
  if (e != null) {
    if (e is String) {
      result = double.parse(e);
    } else if (e is int) {
      result = e.toDouble();
    } else if (e is double) {
      result = e;
    }
  } else {
    result = null;
  }
  return result;
}
