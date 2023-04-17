import 'package:advanced_ecommerce_app/bloc/appCubit/appCubit.dart';
import 'package:advanced_ecommerce_app/bloc/appCubit/appState.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/home_shimmer.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/my_carousel_slider.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/recomended_product.dart';
import 'package:advanced_ecommerce_app/utiles/app_router.dart';
import 'package:advanced_ecommerce_app/utiles/colors.dart';
import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:advanced_ecommerce_app/utiles/my_icon_icons.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/secondary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../widgets/my_home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
   //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AppCubit>(context);
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) => Scaffold(
              backgroundColor: AppColors.buttonBackgroundColor,
              body:

              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.p15,
                    right: Dimensions.p15,
                    top: Dimensions.p45
                ),
                child: Column(
                  children: [
                   const MyHomeAppBar(),
                   cubit.recommendedProducts.isNotEmpty? Expanded(
                      child: SingleChildScrollView(
                        physics:const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height:   Dimensions.p10,),
                           MyCarouselSlider(),
                            SizedBox(height: 3.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                              PrimaryText(text: "Recommended",),
                              SizedBox(width: Dimensions.p10,),
                              Container(
                                margin:const EdgeInsets.only(bottom: 3),
                                  child: PrimaryText(text: ".",color: Colors.black26,)),
                                SizedBox(width: Dimensions.p10,),
                              Container(
                                margin:const EdgeInsets.only(bottom:2),
                                  child: SecondaryText(text: "Food pairing"))
                            ],),
                            SizedBox(height: 1.h,),
                            ListView.separated(
                              itemBuilder:(context,index)=> BuildRecommendedProduct( index: index),
                              separatorBuilder: (context,index)=> SizedBox(height: Dimensions.p10,),
                              itemCount: cubit.recommendedProducts.length,
                              shrinkWrap: true,
                              physics:const NeverScrollableScrollPhysics(),
                            ),
                          ],
                        ),

                      ),
                    ):
                   const HomeShimmer(),

                  ],
                ),
              ),
            ),
        listener: (context, state) {});
  }
}
