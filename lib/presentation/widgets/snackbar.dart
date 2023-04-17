import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:flutter/material.dart';

import '../../utiles/constants.dart';

MySnackBar(String msg,context){
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:  PrimaryText(text: msg,size: Dimensions.p13,),
      )
  );
}