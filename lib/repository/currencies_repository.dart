import '../api/currencies_api.dart';
import '../model/Currency.dart';

class CurrenciesRepository {
  ApiCurrency apiCurrency = ApiCurrency();
  //DbCurrency dbCurrency = DbCurrency();

  Future<List<Currency>> getCurrencies() async {
    List<Currency> listOfCurrencies = await apiCurrency.getcurrencies("BRL");
    return listOfCurrencies;
  }

  Future<Currency> getSelectedCurrency() async {
    Currency currency = Currency("American DOl", "USD");
    return currency;
  }
}
