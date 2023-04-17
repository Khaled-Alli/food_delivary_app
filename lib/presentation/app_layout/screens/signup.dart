import 'dart:async';

import 'package:advanced_ecommerce_app/bloc/registrationCubit/registration_cubit.dart';
import 'package:advanced_ecommerce_app/bloc/registrationCubit/registration_state.dart';
import 'package:advanced_ecommerce_app/data/models/user_model.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/home.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/login.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/otp_screen.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../utiles/app_router.dart';
import '../../../utiles/colors.dart';
import '../../../utiles/constants.dart';
import '../../widgets/text_form_builder.dart';
import '../appLayout.dart';
class SignUpScreen extends StatelessWidget {
   SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<RegistrationCubit,RegistrationState>(listener: (context,state){},builder: (context,state){
    var cubit=BlocProvider.of<RegistrationCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.p15),
            child: Column(
              children: [
                if(state is LoadingSubmitPhoneNumberState)
              Timer(const Duration(seconds: 2),()=>LinearProgressIndicator(color: AppColors.mainColor,),) as Widget,
                SizedBox(
                  // color: Colors.red,
                  height: 22.h,
                  width: 100.w,
                  child: Center(
                    child: Image.asset(Constants.splashImage,width: 70.w,height: 60.h,),
                  ),
                ),
                  Form(
                      key: cubit.signupFormKey,
                      child:Column(
                        children: [
                          Text("Create an account ",style: TextStyle(fontSize: Dimensions.p30,fontWeight:FontWeight.w700,color: AppColors.titleColor),)
                          ,SizedBox(height:Dimensions.p30,),
                          TextFormBuilder(Controller: cubit.signupNameController, TextInputType: TextInputType.name,prefixIcon: const Icon( Icons.person,color: AppColors.mainColor,),hint: "Name",
                              validator:cubit.signUpNameValidation ),
                          SizedBox(height:Dimensions.p20,),
                          TextFormBuilder( Controller: cubit.signupEmailController, TextInputType: TextInputType.emailAddress,prefixIcon:const Icon( Icons.email_outlined,color: AppColors.mainColor,),hint: "Email",
                          validator: cubit.emailValidation),
                          SizedBox(height:Dimensions.p20,),
                          TextFormBuilder(Controller: cubit.signupPhoneController, TextInputType: TextInputType.name,prefixIcon: const Icon(Icons.phone_android_outlined,color: AppColors.mainColor,),hint: "Phone number",
                          validator: cubit.phoneValidation),
                          SizedBox(height:Dimensions.p20,),
                          TextFormBuilder(Controller: cubit.signupPasswordController, TextInputType: TextInputType.visiblePassword,prefixIcon: const Icon( Icons.password_outlined,color: AppColors.mainColor,),hint: "Password",
                          validator: cubit.passwordValidation,suffixIcon: InkWell(child:cubit.signUpObscureText?const Icon( Icons.visibility_off,color: AppColors.mainColor,): const Icon( Icons.visibility,color: AppColors.mainColor,),onTap: ()=>cubit.changeSignUpObscureText(),) ,obscureText: cubit.signUpObscureText),
                          SizedBox(height:Dimensions.p20,),
                          TextFormBuilder(Controller: cubit.signupConfirmPasswordController, TextInputType: TextInputType.visiblePassword,prefixIcon: const Icon(Icons.password_outlined,color: AppColors.mainColor,),hint: "Confirm password",
                          validator: cubit.confirmPasswordValidation,suffixIcon: InkWell(child:cubit.signUpConfirmObscureText?const Icon( Icons.visibility_off,color: AppColors.mainColor,): const Icon( Icons.visibility,color: AppColors.mainColor,),onTap: ()=>cubit.changeSignUpConfirmObscureText(),) ,obscureText: cubit.signUpConfirmObscureText),
                           SizedBox(height:Dimensions.p35,),
                          BottonBuilder(text: "SIGNUP", fun: ()async{
                            if(cubit.signupFormKey.currentState!.validate()){
                              cubit.signupFormKey.currentState!.save();

                              await  cubit.submitPhoneNumber(cubit.signupPhoneController.text).then((value) {
                                  AppRouter.goTo(context, const OTPScreen());
                                //cubit.submitPhoneNumber(cubit.signupPhoneController.text).then((value) =>AppRouter.goTo(context, const OTPScreen()));
                                }).catchError((e) async {
                                MySnackBar(e.toString().substring(e.toString().indexOf("]")+1), context);
                                return null;
                              });
                            }else{
                              MySnackBar("Please, fill all fields", context);
                            }
                          }),
                          SizedBox(
                            height:Dimensions.p35,
                          ),
                          Row(
                            children: [
                              const Text("I have an account "),
                              TextButton(
                                  onPressed: () {
                                    AppRouter.goToWithReplacement(context, LogInScreen());
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: AppColors.mainColor),
                                  )),
                            ],
                          ),
                        ],
                      )),

              ],
            ),
          ),
        ),
      ),
    );});
  }
}
