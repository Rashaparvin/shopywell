import 'package:flutter/material.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/core/strings/image_strings.dart';
import 'package:shopywell/domain/models/onboarding_model.dart';
import 'package:shopywell/presentation/login/login_screen.dart';
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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  void prevPage() {
    if (currentIndex < onboardingPages.length - 1) {
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
      appBar: AppBar(
        backgroundColor: Pallete.kWhiteColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
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
          ),

          // Dot Indicator
          // DotsIndicator(
          //   dotsCount: onboardingPages.length,
          //   position: currentIndex,
          //   decorator: DotsDecorator(
          //     activeColor: Colors.red,
          //     size: const Size.square(8.0),
          //     activeSize: const Size(18.0, 8.0),
          //     activeShape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(5.0)),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: prevPage,
                  child: Text(currentIndex == 0 ? '' : 'Prev',
                      style: TextStyle(color: Pallete.kTextGreyColor)),
                ),
                TextButton(
                  onPressed: nextPage,
                  child: Text(
                      currentIndex == onboardingPages.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: TextStyle(color: Pallete.kTextRedColor)),
                ),
              ],
            ),
          ),
        ],
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
        Image.asset(image, height: 300),
        kSizedBoxHeight(height: 20),
        Text(title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        kSizedBoxHeight(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(color: Pallete.kTextGreyColor, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
