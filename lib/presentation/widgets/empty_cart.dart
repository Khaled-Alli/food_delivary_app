import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:advanced_ecommerce_app/utiles/colors.dart';
import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:flutter/material.dart';
import 'package:build_daemon/constants.dart';
import 'package:sizer/sizer.dart';
class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Dimensions.p20,
                    ),
                    PrimaryText(
                      text: 'The cart is empty',
                    ),
                    Container(
                        width: 60.w,
                        height: 30.h,
                        child: Image.asset(Constants.emptyCartImage)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
