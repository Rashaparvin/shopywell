import 'package:flutter/material.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/presentation/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: PoppinsFonts().kMontserratBold,
        colorScheme: ColorScheme.fromSeed(seedColor: Pallete.kRedColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
