import 'package:flutter/material.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/core/strings/image_strings.dart';
import 'package:shopywell/presentation/login/forgot_pswd.dart';
import 'package:shopywell/presentation/sign_up/signup_screen.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';
import 'package:shopywell/presentation/widgets/social_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();

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
                    'Welcome',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.kMontserratBold),
                  ),
                  Text(
                    'Back!',
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
              kSizedBoxHeight(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPswdScreen()));
                  },
                  child: Text(
                    'Forgot Password?',
                    textAlign: TextAlign.right,
                    style:
                        TextStyle(fontSize: 11, color: Pallete.kTextRedColor),
                  ),
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
                    'Login',
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
                    Text('Create An Account', style: TextStyle(fontSize: 12)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        'Sign Up',
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
