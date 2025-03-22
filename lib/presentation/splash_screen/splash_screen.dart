import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/core/strings/image_strings.dart';
import 'package:shopywell/presentation/splash_screen/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 3000,
        splash: Images.appLogo,
        nextScreen: OnboardingScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Pallete.kWhiteColor,
      ),
    );
  }
}
