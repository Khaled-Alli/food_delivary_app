import 'package:advanced_ecommerce_app/utiles/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../utiles/constants.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80.h,
        width: 100.w,
        child: Shimmer.fromColors(
          baseColor: AppColors.grayColor,
          highlightColor:Colors.white,
          child:Container(
            padding: EdgeInsets.only(
                left: Dimensions.p15,
                right: Dimensions.p15,
                top: Dimensions.p15
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 18.h,
                      width: 5.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only( topRight: Radius.circular(Dimensions.p20),bottomRight: Radius.circular(Dimensions.p20),),
                          color: AppColors.grayColor
                      ),
                    ),
                    SizedBox(width: Dimensions.p10,),
                    Center(
                      child: Container(
                        height: 26.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.p20),
                            color: AppColors.grayColor
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.p10,),
                    Container(
                      height: 18.h,
                      width: 5.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only( topLeft: Radius.circular(Dimensions.p20),bottomLeft: Radius.circular(Dimensions.p20),),
                          color: AppColors.grayColor
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h,),
                ListView.separated(
                  itemBuilder:(context,index)=> Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 35.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: AppColors.grayColor,
                          borderRadius: BorderRadius.circular(Dimensions.p15),
                        ),
                      ),
                      Container(
                        width: 50.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight:Radius.circular(Dimensions.p15,),bottomRight:Radius.circular(Dimensions.p15,),  ),
                          color: Colors.white,
                        ),
                      ),
                    ],),
                  separatorBuilder: (context,index)=> SizedBox(height: Dimensions.p10,),
                  itemCount: 3,
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
