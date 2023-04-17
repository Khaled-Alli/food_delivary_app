import 'package:advanced_ecommerce_app/bloc/registrationCubit/registration_cubit.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/login.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/build_profile_item.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/circle_icon.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:advanced_ecommerce_app/utiles/app_router.dart';
import 'package:advanced_ecommerce_app/utiles/colors.dart';
import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/secondary_text.dart';
import '../../widgets/snackbar.dart';
import 'otp_screen.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   User user = BlocProvider.of<RegistrationCubit>(context).getCurrentUser();
    return Scaffold(

      body: Padding(
        padding:  EdgeInsets.only(top:Dimensions.statusBarH),
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 7.h,
              color: AppColors.mainColor,
              child: Center(
                child: PrimaryText(
                  text: "Profile",
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 28.h,
               padding:  EdgeInsets.only(top: Dimensions.p20,bottom: Dimensions.p30),
               child: Center(child:
                 CircleAvatar(
                   backgroundColor: AppColors.mainColor,
                   radius: Dimensions.p70,
                   child: Icon(Icons.person,color: Colors.white,size: Dimensions.p80,),
                 ),
               ),
             ),
        BuildProfilItem(text: user.displayName.toString(), icon: Icons.person, backgroungColor: AppColors.mainColor),
        SizedBox(height: Dimensions.p15,),
          BuildProfilItem(text: user.phoneNumber.toString(), icon: Icons.phone, backgroungColor: AppColors.iconColor1),
        SizedBox(height: Dimensions.p15,),
          BuildProfilItem(text: user.email.toString(), icon: Icons.email, backgroungColor: AppColors.iconColor1),
        SizedBox(height: Dimensions.p15,),
            InkWell(child: BuildProfilItem(text: "Delete your account", icon: Icons.location_on, backgroungColor: AppColors.iconColor1),
            onTap: ()async{
            //await  BlocProvider.of<RegistrationCubit>(context).submitPhoneNumber(//BlocProvider.of<RegistrationCubit>(context).signupPhoneController.text"01021204207")
          //   await BlocProvider.of<RegistrationCubit>(context).submitPhoneNumber(  "01555074999"//cubit.signupPhoneController.text
              // )
               // await FirebaseAuth.instance.currentUser!.linkWithPhoneNumber("01021204207")
              await BlocProvider.of<RegistrationCubit>(context).deleteCurrentUser()
                  .then((value) {
                AppRouter.goTo(context,  LogInScreen());
                }
              )
                  .catchError((e)async{
                    //await BlocProvider.of<RegistrationCubit>(context).deleteCurrentUser();
              print(e.toString());
              MySnackBar(e.toString().substring(e.toString().indexOf("]")+1), context);
              });
            },),
        SizedBox(height: Dimensions.p15,),
          InkWell(child: BuildProfilItem(text: "LOGOUT", icon: Icons.logout, backgroungColor: AppColors.iconColor3),
          onTap: ()async{
          await BlocProvider.of<RegistrationCubit>(context).logOut();
          AppRouter.goToWithReplacement(context, LogInScreen());
          },),
        SizedBox(height: Dimensions.p15,),


          ],
        ),
      ),
    );
  }
}
