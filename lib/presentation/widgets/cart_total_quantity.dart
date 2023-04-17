import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:flutter/material.dart';

import '../../utiles/constants.dart';
class CartTotalQuantity extends StatelessWidget {
  int totalQuantity;
  Color backgroundColor;
  Color textColor;

   CartTotalQuantity({Key? key,required this.totalQuantity,required this.backgroundColor,required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: Dimensions.p5,
      right: Dimensions.p5,
      child: Container(
        width: Dimensions.p15,
        height: Dimensions.p15,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.p20),
        ),
        child: Center(child: PrimaryText(text: totalQuantity.toString()
          ,color: textColor,
          size: Dimensions.p10,)),
      ),);
  }
}
