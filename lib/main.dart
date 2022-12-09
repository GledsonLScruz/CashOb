import 'package:cashob/pages/details_page.dart';
import 'package:cashob/pages/home_page.dart';
import 'package:cashob/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(ModularApp(module: AppModule(showHome: showHome), child: AppWidget()));
}

class AppModule extends Module {
  final bool showHome;

  AppModule({required this.showHome}) : super();
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        //ChildRoute("/",child: (context, args) => showHome ? HomePage() : OnBoardingPage()),
        ChildRoute("/", child: (context, args) => const HomePage()),
        ChildRoute("/details", child: (context, args) => const DetailPage()),
      ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Smart App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}
