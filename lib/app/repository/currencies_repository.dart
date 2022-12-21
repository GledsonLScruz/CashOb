import '../api/currencies_api.dart';
import '../model/Currency.dart';
import '../sqlite/currency_helper.dart';

class CurrenciesRepository {
  ApiCurrency apiCurrency = ApiCurrency();
  CurrencyHelper dbCurrency = CurrencyHelper();

  Future<List<Currency>> getAllCurrencies() async {
    return _getAllCurrenciesFromAPI(await selectedCurrencyCodeFromDB());
  }

  Future<List<Currency>> getNonSelectedCurrencies() async {
    List<Currency> currencies =
        await _getAllCurrenciesFromAPI(await selectedCurrencyCodeFromDB());
    return currencies.where((element) => element.value != null).toList();
  }

  Future<Currency> getSelectedCurrency() async {
    List<Currency> currencies =
        await _getAllCurrenciesFromAPI(await selectedCurrencyCodeFromDB());
    return currencies.firstWhere((element) => element.value == null);
  }

  Future<void> changeSelectedCurrency(Currency currency) async {
    //DB
  }

  Future<List<Currency>> _getAllCurrenciesFromAPI(String Code) async {
    List<Currency> listOfCurrencies = await apiCurrency.getCurrencies(Code);
    return listOfCurrencies;
  }

  Future<String> selectedCurrencyCodeFromDB() async {
    String code = "BRL";
    try {
      List<Currency> currency = await dbCurrency.list();
      Currency currencys =
          currency.firstWhere((currency) => currency.value == null);
      if (currency != null) {
        code = currencys.code!;
      }
    } catch (e) {}
    return code;
  }
}
