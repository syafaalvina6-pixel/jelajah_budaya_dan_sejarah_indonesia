import 'package:flutter/material.dart';
import 'package:jelajah_budaya_dan_sejarah_indonesia/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jelajah Budaya & Sejarah Indonesia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5A49E3)),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}