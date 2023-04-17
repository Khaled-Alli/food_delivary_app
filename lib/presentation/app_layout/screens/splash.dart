import 'dart:async';

import 'package:advanced_ecommerce_app/presentation/app_layout/screens/login.dart';
import 'package:advanced_ecommerce_app/utiles/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:sizer/sizer.dart';
import '../../../bloc/appCubit/appCubit.dart';
import '../../../utiles/constants.dart';
import '../../widgets/no_internet.dart';
import '../../widgets/primary_text.dart';
import '../appLayout.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  late var initScreen;
  @override
   initState()  {
    FirebaseAuth.instance.authStateChanges().listen((user){
    if(user==null){
      initScreen= LogInScreen();
    }else{
      initScreen= const AppLayout();
    }
  });
     BlocProvider.of<AppCubit>(context).getPopularProducts();
     BlocProvider.of<AppCubit>(context).getRecommendedProducts();
     BlocProvider.of<AppCubit>(context).openBoxes().then((value) {
               BlocProvider.of<AppCubit>(context).totalCartItems();
               BlocProvider.of<AppCubit>(context).getCartItems();
               if(Dimensions.statusBarH==0)
                 Dimensions.statusBarH=MediaQuery.of(context).padding.top;
             });
     controller=AnimationController(vsync: this,duration: const Duration(seconds: 2))..forward();
     animation=CurvedAnimation(parent: controller, curve: Curves.linear);
     Timer(const Duration(seconds: 3),()=>AppRouter.goTo(context, OfflineBuilder(
       connectivityBuilder: (
           BuildContext context,
           ConnectivityResult connectivity,
           Widget child,
           ) {
         final bool connected = connectivity != ConnectivityResult.none;
         if (connected) {
           return initScreen;
         } else {
           return const NoInternetScreen();
         }
       },
       child: Center(child: PrimaryText(text: "Please check internet connection ",),),
     )),);



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScaleTransition(
        scale: animation,
        child: Center(
          child: Image.asset(Constants.splashImage,width: 70.w,height: 60.h,),
        ),
      ),
    );
  }
}
