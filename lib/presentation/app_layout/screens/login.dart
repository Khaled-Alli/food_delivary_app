import 'package:advanced_ecommerce_app/bloc/registrationCubit/registration_state.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/signup.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/snackbar.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/text_form_builder.dart';
import 'package:advanced_ecommerce_app/utiles/app_router.dart';
import 'package:advanced_ecommerce_app/utiles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../bloc/registrationCubit/registration_cubit.dart';
import '../../../data/models/user_model.dart';
import '../../../utiles/constants.dart';
import '../appLayout.dart';
import 'home.dart';
class LogInScreen extends StatelessWidget {
   LogInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  //  var cubit= RegistrationCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.p15),
            child: Column(
              children: [
                SizedBox(
                  // color: Colors.red,
                  height: 22.h,
                  width: 100.w,
                  child: Center(
                    child: Image.asset(Constants.splashImage,width: 70.w,height: 60.h,),
                  ),
                ),
                Text("Welcome Back",style: TextStyle(fontSize: Dimensions.p40,fontWeight:FontWeight.w700,color: AppColors.titleColor),)
                ,SizedBox(height:Dimensions.p35,),
                BlocBuilder<RegistrationCubit,RegistrationState>(builder: (context,state){
                  var cubit= BlocProvider.of<RegistrationCubit>(context);
                  return Form(
                      key: cubit.loginFormKey,
                      child: Column(
                        children: [
                          //     TextFormBuilder( emailController, TextInputType: TextInputType.name,suffixIcon: Icons.email_outlined,hint: "hhh",),
                          TextFormBuilder(Controller: cubit.loginEmailController, TextInputType: TextInputType.emailAddress,prefixIcon: const Icon(Icons.email,color: AppColors.mainColor,),hint: "Email"),
                          SizedBox(height:Dimensions.p20,),
                          TextFormBuilder(Controller: cubit.loginPasswordController, TextInputType: TextInputType.visiblePassword,prefixIcon: const Icon( Icons.password_outlined,color: AppColors.mainColor,),hint: "Password"
                              ,suffixIcon: InkWell(child:cubit.loginObscureText?const Icon( Icons.visibility_off,color: AppColors.mainColor,): const Icon( Icons.visibility,color: AppColors.mainColor,),onTap: ()=>cubit.changeLoginObscureText(),) ,obscureText: cubit.loginObscureText),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Forget Password?",
                                    style: TextStyle(color: AppColors.mainColor),
                                  ))
                            ],
                          ),
                          SizedBox(height:Dimensions.p35,),
                          BottonBuilder(text: "LOGIN", fun: ()async{
                            if(cubit.loginFormKey.currentState!.validate()){
                              cubit.loginFormKey.currentState!.save();
                              cubit.logIn(MyUser(
                                email: cubit.loginEmailController.text,
                                password: cubit.loginPasswordController.text,
                              )).then((value)=>AppRouter.goToWithReplacement(context, const AppLayout()))

                                  .catchError((e) async {
                                //.catchError((e)=>print("linkCurrentUserWithPhone : " +e.toString()))
                                MySnackBar(e.toString().substring(e.toString().indexOf("]")+1), context);
                                return null;
                              });
                            }else{
                              MySnackBar("NOT Registered", context);
                            }
                          }),
                          SizedBox(
                            height:Dimensions.p35,
                          ),
                          Row(
                            children: [
                              const Text("Don't have an account ?"),
                              TextButton(
                                  onPressed: () {
                                    AppRouter.goToWithReplacement(context, SignUpScreen());
                                  },
                                  child: const Text(
                                    "Create",
                                    style: TextStyle(color: AppColors.mainColor),
                                  )),
                            ],
                          ),
                        ],
                      ));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
