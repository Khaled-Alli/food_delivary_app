import 'dart:io';
import 'package:advanced_ecommerce_app/bloc/registrationCubit/registration_cubit.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/otp_screen.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:advanced_ecommerce_app/data/models/cart_item_model.dart';
import 'package:advanced_ecommerce_app/data/repository/app_repository.dart';
import 'package:advanced_ecommerce_app/data/web_services/app_web_service.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/home.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/login.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/popular_meal_details.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/recommended_meal_details.dart';
import 'package:advanced_ecommerce_app/bloc/appCubit/appCubit.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/splash.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/home_shimmer.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/no_internet.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:advanced_ecommerce_app/utiles/app_router.dart';
import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'presentation/app_layout/appLayout.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory dir =await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  //await Hive.openBox(Constants.cartBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create:(context)=> AppCubit(AppRepository(AppWebServices())),
        ),
        BlocProvider<RegistrationCubit>(
          create:(context)=> RegistrationCubit(),
        ),
      ],
      child: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Constants.appName,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home:
              //MainMealDetailsScreen(),
             const SplashScreen(),
           //   SignUpScreen(),
            //  OTPScreen(),
              // PopularMealDetails(),
           //  initialRoute: Constants.splashRout,
           //  routes: AppRouter.routs,
            );
          }
      ),
    );


  }
}

