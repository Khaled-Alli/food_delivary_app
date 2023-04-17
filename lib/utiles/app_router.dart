import 'package:advanced_ecommerce_app/presentation/app_layout/screens/home.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/popular_meal_details.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/recommended_meal_details.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants.dart';
class AppRouter {

  AppRouter() ;

  static Map<String,Widget Function(BuildContext)> routs= {
    Constants.homeRout:(context)=>const HomeScreen(),
    Constants.splashRout:(context)=>const SplashScreen(),
  };

  static void goTo(context, screen){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  screen),
    );
  }

  static void pop(context){
    if(Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  static void popAll(context){

      Navigator.of(context).popUntil(ModalRoute.withName(Constants.homeRout));

  }

  static void goToWithReplacement(context, screen){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  screen),
    );
  }
}