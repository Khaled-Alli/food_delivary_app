import 'dart:ui';


import 'package:advanced_ecommerce_app/bloc/appCubit/appCubit.dart';
import 'package:advanced_ecommerce_app/bloc/appCubit/appState.dart';
import 'package:advanced_ecommerce_app/data/models/app_model.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/popular_meal_details.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/secondary_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../utiles/app_router.dart';
import '../../utiles/colors.dart';
import '../../utiles/constants.dart';
import '../../utiles/my_icon_icons.dart';

class MyCarouselSlider extends StatelessWidget {

  MyCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {

    List<Product> products=BlocProvider.of<AppCubit>(context).popularProducts;
    var cubit=BlocProvider.of<AppCubit>(context);
  return BlocBuilder<AppCubit,AppState>(builder: (context,_)=>
        Column(
          children: [
            CarouselSlider(
                items: products.map(
                      (product) => InkWell(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 26.h,
                          width: 70.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.p20),
                            child: Image.network(
                              Constants.baseURL+Constants.uploads+product.img.toString(),

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
                                      height: 26.h,
                                      width: 70.w,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 60.w,
                            height: 14.h,
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFe8e8e8),
                                  blurRadius: 5.0,
                                  offset: Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-5, 0),
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(5, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.p20),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.p5,
                              vertical: Dimensions.p15,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  text: product.name.toString(),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(
                                        5,
                                            (index) => Icon(
                                          Icons.star,
                                          color: AppColors.mainColor,
                                          size: Dimensions.p15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.p5,
                                    ),
                                    SecondaryText(
                                      text: product.stars.toString(),
                                    ),
                                    SizedBox(
                                      width: Dimensions.p10,
                                    ),
                                    SecondaryText(text: "1297"),
                                    SizedBox(
                                      width: Dimensions.p5,
                                    ),
                                    SecondaryText(text: "Comments"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.circle_sharp,
                                          color: AppColors.yellowColor,
                                          size: Dimensions.p20,
                                        ),
                                        SizedBox(
                                          width: Dimensions.p5,
                                        ),
                                        SecondaryText(text: "Normal"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          MyIcon.location_on,
                                          color: AppColors.mainColor,
                                          size: Dimensions.p20,
                                        ),
                                        SizedBox(
                                          width: Dimensions.p5,
                                        ),
                                        SecondaryText(text: "1 km"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          MyIcon.clock,
                                          color: Colors.redAccent,
                                          size: Dimensions.p20,
                                        ),
                                        SizedBox(
                                          width: Dimensions.p5,
                                        ),
                                        SecondaryText(text: "32 min"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () async{
                       // cubit.selectedProduct=product;
                        await cubit.initDetailsPage(product);
                        cubit.totalCartItems();
                        AppRouter.goTo(context,  PopularMealDetailsScreen( selectedProduct: product,)//Constants.popularMealDetailsRout
                        );
                    }
                  ),
                ).toList(),
                options: CarouselOptions(
                  aspectRatio: 11.5 / 9,
                  viewportFraction: 0.77,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                      onPageChanged: (index, _) =>cubit.updateCarouselSlider(index.toDouble()),
                )),
            SizedBox(
              height: Dimensions.p25,
            ),
            DotsIndicator(
              dotsCount: products.isEmpty?1:products.length,
                 position: cubit.CarouselSliderIndex,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size:  Size.square(Dimensions.p8),
                activeSize:  Size(Dimensions.p18, Dimensions.p8),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.p5)),
              ),
            ),
          ],
        ));
  }
}
