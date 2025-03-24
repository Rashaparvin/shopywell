import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/domain/bloc/login/login_bloc.dart';
import 'package:shopywell/domain/bloc/product/product_bloc.dart';
import 'package:shopywell/domain/bloc/signup/signup_bloc.dart';
import 'package:shopywell/presentation/home/bottom_navigation.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state1) {
          return BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginViaEmailSuccess ||
                  state is LoginViaGoogleSuccess ||
                  state1 is SignupViaEmailSuccess ||
                  state is LoginUserFound) {
                return Stack(
                  children: [
                    Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/authentic_bgrnd.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SizedBox.shrink()),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withAlpha(200),
                                Colors.black.withAlpha(120),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'You want Authentic, here you go!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            kSizedBoxHeight(height: 15),
                            Text('Find it here, buy it now!',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            kSizedBoxHeight(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ProductBloc>()
                                      .add(FetchProducts());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottonNavigationWithScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Pallete.kRedColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Get Started',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Pallete.kTextWhiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            kSizedBoxHeight(height: 20)
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              return SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
