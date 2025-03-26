import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/domain/bloc/login/login_bloc.dart';
import 'package:shopywell/domain/bloc/user_profile/user_profile_bloc.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class ForgotPswdScreen extends StatelessWidget {
  const ForgotPswdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    context.read<UserProfileBloc>().add(FetchUserDetails());
    return Scaffold(
      backgroundColor: Pallete.kWhiteColor,
      body: SingleChildScrollView(
        child: BlocListener<UserProfileBloc, UserProfileState>(
          listener: (context, state) {
            if (state is UserDetailsFetched) {
              email.text = state.user.email ?? '';
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kSizedBoxHeight(height: 10),
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
                        fontSize: 13, fontFamily: Fonts.kMontserratLight),
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
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is PasswordResetMailSent) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Follow the link send to your email account..'),
                        backgroundColor: Colors.grey,
                      ));
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<LoginBloc>()
                            .add(ForgotPassword(email: email.text));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.kRedColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 16, color: Pallete.kTextWhiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
