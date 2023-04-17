import 'package:advanced_ecommerce_app/bloc/appCubit/appCubit.dart';
import 'package:advanced_ecommerce_app/bloc/appCubit/appState.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/recommended_meal_details.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/secondary_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../utiles/app_router.dart';
import '../../utiles/colors.dart';
import '../../utiles/constants.dart';
import '../../utiles/my_icon_icons.dart';
class BuildRecommendedProduct extends StatelessWidget {

  int index;
   BuildRecommendedProduct({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var cubit= BlocProvider.of<AppCubit>(context);
    return BlocBuilder<AppCubit,AppState>(builder: (context,_)=>
        InkWell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.p15),
            child: Container(
              width: 37.w,
              height: 14.h,
              child: Image.network(Constants.baseURL+Constants.uploads+cubit.recommendedProducts[index].img.toString(),
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Shimmer.fromColors(
                      baseColor: AppColors.grayColor,
                      highlightColor:Colors.white,
                      child: Container(
                        width: 37.w,
                        height: 14.h,
                        color: Colors.white,
                      ),
                    );
                  }
                },
                fit: BoxFit.cover,),
            ),

          ),
          Container(
            width: 54.w,
            height: 10.h,
            padding: EdgeInsets.only(left: Dimensions.p10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight:Radius.circular(Dimensions.p15,),bottomRight:Radius.circular(Dimensions.p15,),  ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  text: cubit.recommendedProducts[index].name.toString(),
                  size: 100.h/(100.h/16),
                ),
                SecondaryText(
                  text: cubit.recommendedProducts[index].description.toString(),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle_sharp,
                          color:
                          AppColors.yellowColor,
                          size: Dimensions.p15,
                        ),
                        SizedBox(width: Dimensions.p5,),
                        SecondaryText(text: "Normal"),
                      ],
                    ),
                    SizedBox(width: Dimensions.p8,),
                    Row(
                      children: [
                        Icon(
                          MyIcon.location_on,
                          color: AppColors.mainColor,
                          size: Dimensions.p15,
                        ),
                        SizedBox(width: Dimensions.p5,),
                        SecondaryText(text: "1 km"),
                      ],
                    ),
                    SizedBox(width: Dimensions.p8,),
                    Row(
                      children: [
                        Icon(
                          MyIcon.clock,
                          color: Colors.redAccent,
                          size: Dimensions.p15,
                        ),
                        SizedBox(width: Dimensions.p5,),
                        SecondaryText(text: "32 min"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],),
      onTap: ()async{
        //cubit.selectedProduct=cubit.recommendedProducts[index];
        await cubit.initDetailsPage(cubit.recommendedProducts[index]);
        cubit.totalCartItems();
        AppRouter.goTo(context, RecommendedMealDetails( selectedProduct: cubit.recommendedProducts[index],));}
    ));
  }
}
