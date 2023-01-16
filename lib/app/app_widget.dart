import 'package:cashob/app/Utils/colors.dart';
import 'package:cashob/app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CashOb',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
