// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';

import 'package:shopywell/core/strings/image_strings.dart';
import 'package:shopywell/domain/bloc/user_profile/user_profile_bloc.dart';
import 'package:shopywell/domain/models/user_model/user_details_modl.dart';
import 'package:shopywell/presentation/home/bottom_navigation.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserProfileBloc>().add(FetchUserDetails());
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController(text: '********');
    TextEditingController pincode = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController city = TextEditingController();
    TextEditingController state = TextEditingController();
    TextEditingController country = TextEditingController();
    TextEditingController bankAccountNumber = TextEditingController();
    TextEditingController accountHolderName = TextEditingController();
    TextEditingController ifscCode = TextEditingController();
    String image = Images.userIcon;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: BlocListener<UserProfileBloc, UserProfileState>(
          listener: (context, userProState) {
            if (userProState is UserDetailsFetched) {
              email.text = userProState.user.email ?? '';
              image = userProState.user.photoURL ?? Images.userIcon;
              context
                  .read<UserProfileBloc>()
                  .add(FetchUserProfileDetails(email: email.text));
            } else if (userProState is UserProfileLoadedSuccess) {
              pincode.text = userProState.userProfile.pincode;
              address.text = userProState.userProfile.address;
              city.text = userProState.userProfile.city;
              state.text = userProState.userProfile.state;
              country.text = userProState.userProfile.country;
              bankAccountNumber.text =
                  userProState.userProfile.bankAccountNumber;
              accountHolderName.text =
                  userProState.userProfile.accountHolderName;
              ifscCode.text = userProState.userProfile.ifscCode;
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: AssetImage(image),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child:
                                Icon(Icons.edit, color: Colors.white, size: 18),
                          ),
                        )
                      ],
                    ),
                    kSizedBoxHeight(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Personal Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    kSizedBoxHeight(height: 10),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email Address',
                              style: const TextStyle(fontSize: 14),
                            ),
                            kSizedBoxHeight(height: 5),
                            TextFormField(
                              controller: email,
                              obscureText: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        kSizedBoxHeight(height: 15),
                        BuildTextField(
                          label: 'Password',
                          obscureText: true,
                          controller: password,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Change Password',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              kSizedBoxHeight(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Business Address Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    kSizedBoxHeight(height: 10),
                    BuildTextField(
                      label: 'Pincode',
                      controller: pincode,
                      obscureText: false,
                    ),
                    kSizedBoxHeight(height: 15),
                    BuildTextField(
                      label: 'Address',
                      obscureText: false,
                      controller: address,
                    ),
                    kSizedBoxHeight(height: 10),
                    kSizedBoxHeight(height: 10),
                    BuildTextField(
                      label: 'City',
                      controller: city,
                      obscureText: false,
                    ),
                    kSizedBoxHeight(height: 15),
                    BuildTextField(
                      label: 'State',
                      obscureText: false,
                      controller: state,
                    ),
                    kSizedBoxHeight(height: 15),
                    BuildTextField(
                      label: 'Country',
                      obscureText: false,
                      controller: country,
                    ),
                  ],
                ),
              ),
              kSizedBoxHeight(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              kSizedBoxHeight(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Bank Account Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    kSizedBoxHeight(height: 10),
                    BuildTextField(
                      label: 'Bank Account Number',
                      controller: bankAccountNumber,
                      obscureText: false,
                    ),
                    kSizedBoxHeight(height: 15),
                    BuildTextField(
                      label: "Account Holder's Name",
                      obscureText: false,
                      controller: accountHolderName,
                    ),
                    kSizedBoxHeight(height: 15),
                    BuildTextField(
                      label: 'IFSC Code',
                      obscureText: false,
                      controller: ifscCode,
                    ),
                    kSizedBoxHeight(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          UserDetailsModel userProfileData = UserDetailsModel(
                              email: email.text,
                              password: password.text,
                              pincode: pincode.text,
                              address: address.text,
                              city: city.text,
                              state: state.text,
                              country: country.text,
                              bankAccountNumber: bankAccountNumber.text,
                              accountHolderName: accountHolderName.text,
                              ifscCode: ifscCode.text);
                          context
                              .read<UserProfileBloc>()
                              .add(AddUserProfile(userData: userProfileData));
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
                          'Save',
                          style: TextStyle(
                              fontSize: 16,
                              color: Pallete.kTextWhiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              kSizedBoxHeight(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  const BuildTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        kSizedBoxHeight(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
