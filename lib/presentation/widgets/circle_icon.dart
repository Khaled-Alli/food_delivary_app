import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  Color backgroundColor;
  Color iconColor;
  double iconSize;
  double? circleWidth;
  double? circleHight;
  double? borderRadius;
  IconData icon;



  CircleIcon({
    Key? key,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.iconSize = 20,
    this.circleHight,
    this.circleWidth,
    this.borderRadius,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleWidth??Dimensions.p35,
      height: circleHight??Dimensions.p35,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius??Dimensions.p20),
      ),
      child: Center(child: Icon(icon,color: iconColor,size: iconSize,)),
    );
  }
}
