import 'package:advanced_ecommerce_app/bloc/registrationCubit/registration_cubit.dart';
import 'package:advanced_ecommerce_app/bloc/registrationCubit/registration_state.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/home.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/login.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:advanced_ecommerce_app/utiles/app_router.dart';
import 'package:advanced_ecommerce_app/utiles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../data/models/user_model.dart';
import '../../../utiles/constants.dart';
import '../../widgets/snackbar.dart';
import '../../widgets/text_form_builder.dart';
import '../appLayout.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String otpCode;
    //submitOTP
    var cubit = BlocProvider.of<RegistrationCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.p15),
            child: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  // color: Colors.red,
                  height: 22.h,
                  width: 100.w,
                  child: Center(
                    child: Image.asset(
                      Constants.splashImage,
                      width: 70.w,
                      height: 60.h,
                    ),
                  ),
                ),
                InkWell(
                  child: PrimaryText(text: 'Verify your phone number'),
                  onTap: () {
                    AppRouter.pop(context);
                  },
                ),
                SizedBox(
                  height: 5.h,
                ),
                PinCodeTextField(
                  appContext: context,
                  autoFocus: true,
                  cursorColor: AppColors.paraColor,
                  keyboardType: TextInputType.number,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.scale,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: Dimensions.p50,
                    fieldWidth: Dimensions.p40,
                    borderWidth: 1,
                    activeColor: AppColors.mainColor,
                    inactiveColor: AppColors.mainColor,
                    inactiveFillColor: Colors.white,
                    activeFillColor: AppColors.mainColor,
                    selectedColor: AppColors.mainColor,
                    selectedFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  enableActiveFill: true,
                  onCompleted: (submittedCode) {
                    otpCode = submittedCode;
                    print("Completed : " + otpCode);
                  },
                  onChanged: (value) {
                    print(value);
                  },
                ),
                SizedBox(
                  height: 4.h,
                ),
                BlocConsumer<RegistrationCubit, RegistrationState>( listener: (context,state){},
                  builder: (context, state) => BottonBuilder(
                      text: "Verify",
                      fun: () async {
                        await cubit.submitOTP(otpCode).then((value) async {
                          if(state is OTPSubmitted) {
                            MySnackBar("Phone Verified", context);
                          }
                          //    MySnackBar("Registered", context);
                          await cubit.updateUserData(MyUser(
                            name: cubit.signupNameController.text,
                            phone: cubit.signupPhoneController.text,
                            email: cubit.signupEmailController.text,
                            password: cubit.signupPasswordController.text,
                          ))
                              .then((value)  {
                            AppRouter.goToWithReplacement(context, const AppLayout());
                        }).catchError((e)async {
                            await cubit.deleteCurrentUser();
                            AppRouter.goToWithReplacement(context, LogInScreen());
                            MySnackBar("something went wrong !", context);
                            //   print("not verified : " + e.toString());
                          });

                        });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
