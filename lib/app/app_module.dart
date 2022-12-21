import 'package:cashob/app/repository/currencies_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/about_page.dart';
import 'pages/details_page.dart';
import 'pages/home_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/select_page.dart';

class AppModule extends Module {
  final bool showHome;
  AppModule({required this.showHome}) : super();

  @override
  List<Bind> get binds =>
      [Bind.lazySingleton<CurrenciesRepository>((i) => CurrenciesRepository())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/",
            child: (context, args) =>
                showHome ? HomePage() : const OnBoardingPage()),
        ChildRoute("/home", child: (context, args) => HomePage()),
        ChildRoute("/details", child: (context, args) => const DetailPage()),
        ChildRoute("/select", child: (context, args) => SelectPage()),
        ChildRoute("/about", child: (context, args) => const AboutPage())
      ];
}
