import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/data/db_functions/db_functions.dart';
import 'package:shopywell/data/provider/product/product_provider.dart';
import 'package:shopywell/data/repository/login_repo/login_repository.dart';
import 'package:shopywell/data/repository/product_repo/product_repository.dart';
import 'package:shopywell/data/repository/product_repo/wishlist_repository.dart';
import 'package:shopywell/data/repository/signup_repository/signup_repository.dart';
import 'package:shopywell/domain/bloc/login/login_bloc.dart';
import 'package:shopywell/domain/bloc/product/product_bloc.dart';
import 'package:shopywell/domain/bloc/signup/signup_bloc.dart';
import 'package:shopywell/domain/bloc/wish_list/wishlist_bloc.dart';
import 'package:shopywell/presentation/splash_screen/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Platform.isWindows) {
    await Firebase.initializeApp();
  }
  await LocalDatabase().dataBaseInitialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LoginRepo(),
        ),
        RepositoryProvider(
          create: (context) => SignupRepository(),
        ),
        RepositoryProvider(
          create: (context) =>
              ProductRepository(productProvider: ProductProvider()),
        ),
        RepositoryProvider(
          create: (context) => WishlistRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(context.read<LoginRepo>()),
          ),
          BlocProvider(
            create: (context) => SignupBloc(context.read<SignupRepository>()),
          ),
          BlocProvider(
            create: (context) => ProductBloc(
              context.read<ProductRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => WishlistBloc(
              context.read<WishlistRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: Fonts.kMontserratNormal,
            colorScheme: ColorScheme.fromSeed(seedColor: Pallete.kRedColor),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
