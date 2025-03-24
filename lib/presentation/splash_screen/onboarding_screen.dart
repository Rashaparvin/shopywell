import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/core/constants/main_variables.dart';
import 'package:shopywell/core/strings/image_strings.dart';
import 'package:shopywell/domain/bloc/login/login_bloc.dart';
import 'package:shopywell/domain/models/onboarding_model.dart';
import 'package:shopywell/presentation/login/login_screen.dart';
import 'package:shopywell/presentation/splash_screen/get_start_screen.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  // Define Onboarding Pages using the Model
  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: Images.onBoardingImage1,
      title: 'Choose Products',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingModel(
      image: Images.onBoardingImage2,
      title: 'Make Payment',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingModel(
      image: Images.onBoardingImage3,
      title: 'Get Your Order',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
  ];

  void nextPage() {
    if (currentIndex < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      context.read<LoginBloc>().add(GetLogginedUser());
    }
  }

  void prevPage() {
    if (currentIndex <= onboardingPages.length - 1) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.kWhiteColor,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginUserFound) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => GetStartScreen()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${currentIndex + 1}/${onboardingPages.length}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Pallete.kTextBlackColor,
                          fontFamily: Fonts.kMontserratBold)),
                  TextButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(GetLogginedUser());
                    },
                    child: Text('Skip',
                        style: TextStyle(
                            fontSize: 16,
                            color: Pallete.kTextBlackColor,
                            fontFamily: Fonts.kMontserratBold)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: pageController,
                    itemCount: onboardingPages.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final page = onboardingPages[index];
                      return OnboardingContent(
                        image: page.image,
                        title: page.title,
                        description: page.description,
                      );
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: SizedBox(
                        width: Dimensions.screenWidth(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: prevPage,
                              child: Text(currentIndex == 0 ? '' : 'Prev',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Pallete.kTextGreyColor,
                                      fontFamily: Fonts.kMontserratBold)),
                            ),
                            DotsIndicator(
                              dotsCount: onboardingPages.length,
                              position: currentIndex.toDouble(),
                              decorator: DotsDecorator(
                                activeColor: Pallete.kBlackColor,
                                size: const Size.square(8.0),
                                activeSize: const Size(30.0, 8.0),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                            TextButton(
                              onPressed: nextPage,
                              child: Text(
                                  currentIndex == onboardingPages.length - 1
                                      ? 'Get Started'
                                      : 'Next',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Pallete.kTextRedColor,
                                      fontFamily: Fonts.kMontserratBold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Onboarding Content Widget
class OnboardingContent extends StatelessWidget {
  final String image, title, description;
  const OnboardingContent(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: Dimensions.screenHeight(context) * 0.4),
        kSizedBoxHeight(height: 20),
        Text(title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: Fonts.kMontserratBold)),
        kSizedBoxHeight(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Pallete.kTextGreyColor,
                fontSize: 14,
                fontFamily: Fonts.kMontserratBold),
          ),
        ),
      ],
    );
  }
}
