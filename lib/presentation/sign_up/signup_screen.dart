import 'package:flutter/material.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/core/strings/image_strings.dart';
import 'package:shopywell/presentation/login/login_screen.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';
import 'package:shopywell/presentation/widgets/social_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPswd = TextEditingController();

    return Scaffold(
      backgroundColor: Pallete.kWhiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create an',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.kMontserratBold),
                  ),
                  Text(
                    'account',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.kMontserratBold),
                  ),
                ],
              ),
              kSizedBoxHeight(height: 20),
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.person_rounded, size: 20),
                  hintText: 'Username or Email',
                  hintStyle: TextStyle(
                      fontSize: 11, fontFamily: Fonts.kMontserratLight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              kSizedBoxHeight(height: 20),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.lock, size: 18),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined, size: 18),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                      fontSize: 11, fontFamily: Fonts.kMontserratLight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              kSizedBoxHeight(height: 20),
              TextFormField(
                controller: confirmPswd,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.lock, size: 18),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined, size: 18),
                  hintText: 'Confirm password',
                  hintStyle: TextStyle(
                      fontSize: 11, fontFamily: Fonts.kMontserratLight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              kSizedBoxHeight(height: 8),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: TextStyle(
                      fontFamily: Fonts.kMontserratNormal,
                      fontSize: 12,
                      color: Pallete.kTextBlackColor),
                  children: [
                    TextSpan(text: 'By clicking the '),
                    TextSpan(
                      text: 'Register',
                      style: TextStyle(
                          fontFamily: Fonts.kMontserratNormal,
                          color: Pallete.kTextRedColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text: ' button, you agree to the public offer',
                        style: TextStyle(
                          fontFamily: Fonts.kMontserratNormal,
                        )),
                  ],
                ),
              ),
              kSizedBoxHeight(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.kRedColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Create Account',
                    style:
                        TextStyle(fontSize: 16, color: Pallete.kTextWhiteColor),
                  ),
                ),
              ),
              kSizedBoxHeight(height: 30),
              Center(
                child: Text(
                  '- OR Continue with -',
                  style: TextStyle(fontSize: 11),
                ),
              ),
              kSizedBoxHeight(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(icon: Images.google),
                  kSizedBoxWidth(width: 20),
                  SocialLoginButton(icon: Images.apple),
                  kSizedBoxWidth(width: 20),
                  SocialLoginButton(icon: Images.facebook),
                ],
              ),
              kSizedBoxHeight(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('I Already Have an Account ',
                        style: TextStyle(fontSize: 12)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 12,
                            color: Pallete.kTextRedColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
