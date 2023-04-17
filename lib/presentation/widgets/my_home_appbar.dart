import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/secondary_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utiles/colors.dart';
import '../../utiles/constants.dart';
class MyHomeAppBar extends StatelessWidget {
  const MyHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 100.w,
      height: 7.h,

      color: AppColors.buttonBackgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: "Egypt",
                color: AppColors.mainColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SecondaryText(
                    text: "Minia",
                    color: AppColors.mainBlackColor,
                  ),
                  Icon(Icons.arrow_drop_down_sharp,
                      size: Dimensions.p25),
                ],
              ),
            ],
          ),
          Container(
            width: Dimensions.p45,
            height: Dimensions.p45,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius:
              BorderRadius.circular(Dimensions.p15),
            ),
            child: Icon(
              Icons.search,
              size: Dimensions.p20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
