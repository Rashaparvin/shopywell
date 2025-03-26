import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/core/constants/main_variables.dart';
import 'package:shopywell/domain/bloc/login/login_bloc.dart';
import 'package:shopywell/presentation/login/login_screen.dart';
import 'package:shopywell/presentation/widgets/sizedbox_widget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Dimensions.screenWidth(context) * 0.6,
      child: SafeArea(
        child: Column(
          children: [
            kSizedBoxHeight(height: 20),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Logout", style: TextStyle(color: Colors.red)),
                onTap: () async {
                  context.read<LoginBloc>().add(LogoutRequested());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
