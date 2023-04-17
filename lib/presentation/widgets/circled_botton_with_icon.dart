import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:flutter/material.dart';

class CircledBottonWithIcon extends StatelessWidget {
  Color backgroundColor;
  Color iconColor;
  double iconSize;
 // double bottonSize;
  IconData icon;
  Function() fun;

  CircledBottonWithIcon({
    Key? key,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.iconSize = 20,
    required this.icon,
    required this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: Container(
        width: Dimensions.p35,
        height: Dimensions.p35,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.p20),
        ),
        child: Center(child: Icon(icon,color: iconColor,size: iconSize,)),
      ),
    
    );
  }
}
