import 'dart:io';

import 'package:cashob/app/repository/currencies_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  final selectedCurrency = prefs.getString('selectedCurrency');
  if (selectedCurrency == null) {
    prefs.setString('selectedCurrency', 'BRL');
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CurrenciesRepository(),
        lazy: false,
      )
    ],
    child: const AppWidget(),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
