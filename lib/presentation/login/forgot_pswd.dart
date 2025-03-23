import 'package:flutter/material.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class ForgotPswdScreen extends StatelessWidget {
  const ForgotPswdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();

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
                    'Forgot',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.kMontserratBold),
                  ),
                  Text(
                    'password?',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.kMontserratBold),
                  ),
                ],
              ),
              kSizedBoxHeight(height: 20),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.mail_rounded, size: 20),
                  hintText: 'Enter your email address',
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
              kSizedBoxHeight(height: 25),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: TextStyle(
                      fontFamily: Fonts.kMontserratNormal,
                      fontSize: 12,
                      color: Pallete.kTextBlackColor),
                  children: [
                    TextSpan(
                      text: '*',
                      style: TextStyle(
                          fontFamily: Fonts.kMontserratNormal,
                          color: Pallete.kTextRedColor),
                    ),
                    TextSpan(
                        text:
                            ' We will send you a message to set or reset your new password '),
                  ],
                ),
              ),
              kSizedBoxHeight(height: 30),
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
                    'Submit',
                    style:
                        TextStyle(fontSize: 16, color: Pallete.kTextWhiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
