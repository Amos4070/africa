import 'package:africa/screen_repo/screen/home_screen.dart';
import 'package:africa/screen_repo/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Changed to official flutter_bloc
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'bloc/countries_bloc/country_bloc.dart';

void
    main() {
  runApp(const ParentApp());
}

///this logic allows Homescree() widget to directly inherit the contect of
///the Bloc statemanagement
class MyApp
    extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountryBloc>(
      create: (context) => CountryBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}

class ParentApp
    extends StatelessWidget {
  const ParentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

///The instruction was carefuly followed Bloc is used for the app statemanagement
///getx is only used for animated navigation
