import 'package:advanced_ecommerce_app/utiles/colors.dart';
import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
Widget TextFormBuilder({prefixIcon,obscureText=false,required Controller, hint, validator,suffixIcon,required TextInputType}){
  return   TextFormField(
    // autofocus: true,

    obscureText:obscureText ,
    // keyboardAppearance:Brightness.dark ,
    controller:Controller ,
    keyboardType: TextInputType,
    decoration: InputDecoration(
    //  suffix: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor,),

          borderRadius: BorderRadius.circular(Dimensions.p45)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.mainColor,),

        borderRadius: BorderRadius.circular(Dimensions.p45),
      ),
      focusedErrorBorder:OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,),

        borderRadius: BorderRadius.circular(Dimensions.p45),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,),

        borderRadius: BorderRadius.circular(Dimensions.p45),
      ),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
     // suffixIconColor: AppColors.paraColor,
      hintText: hint,
      //enabled: true,
    ),

    validator: validator,

  );

}
Widget BottonBuilder({required text,required fun}){
  return  Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.p45),
      color: AppColors.mainColor,
    ),
    height: Dimensions.p55,
    width: 100.w,
    child: MaterialButton(onPressed: fun,child: Text(text,style: TextStyle(color: Colors.white,fontSize: Dimensions.p25,),textAlign: TextAlign.center,),),
  );
}
