import 'package:advanced_ecommerce_app/bloc/appCubit/appCubit.dart';
import 'package:advanced_ecommerce_app/bloc/appCubit/appState.dart';
import 'package:advanced_ecommerce_app/data/models/app_model.dart';
import 'package:advanced_ecommerce_app/data/models/cart_item_model.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/cart.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/cart_total_quantity.dart';
import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:advanced_ecommerce_app/utiles/my_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../utiles/app_router.dart';
import '../../../utiles/colors.dart';
import '../../widgets/circled_botton_with_icon.dart';
import '../../widgets/primary_text.dart';
import '../../widgets/secondary_text.dart';
import 'dart:ui';

class PopularMealDetailsScreen extends StatelessWidget {
  Product selectedProduct;
   PopularMealDetailsScreen({Key? key,required this.selectedProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sBar=MediaQuery.of(context).padding.top;
    var cubit=BlocProvider.of<AppCubit>(context);
    return BlocBuilder<AppCubit,AppState>(builder: (context,state)=>
        Scaffold(
          body: Padding(
            padding:EdgeInsets.only(top:Dimensions.statusBarH, ) ,
            child: Container(
              height: 100.h,
              child: Stack(
                children: [
                  Container(
                    width: 100.w,
                    height: 33.h,
                    child:
                    Image.network(Constants.baseURL+Constants.uploads+selectedProduct.img!,
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
                              width: 100.w,
                              height: 33.h,
                              color: Colors.white,
                            ),
                          );
                        }
                      },
                      fit: BoxFit.cover,),),
                  Positioned(
                    top: Dimensions.p25,
                    left: Dimensions.p20,
                    right: Dimensions.p20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircledBottonWithIcon(icon: Icons.arrow_back_ios_new, fun:() {
                          AppRouter.pop(context);
                        },iconSize: Dimensions.p15,),
                        InkWell(
                          child: Stack(
                            children: [

                              CircledBottonWithIcon(icon: Icons.shopping_cart_outlined, fun: (){
                                AppRouter.goTo(context, const CartScreen());
                              },iconSize: Dimensions.p15,),
                            if(cubit.totalItemsQuantitiesInCart>0)
                              CartTotalQuantity(totalQuantity: cubit.totalItemsQuantitiesInCart, backgroundColor:  AppColors.mainColor, textColor:  Colors.white)
                            ],
                          ),
                          onTap: (){
                            AppRouter.goTo(context, const CartScreen());
                          },
                        ),
                      ],),),
                  Positioned(
                    top: 33.h -15,
                    left: 0,
                    right: 0,
                    bottom: 11.h,
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.p20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft:Radius.circular(Dimensions.p25) ,
                          topRight:Radius.circular(Dimensions.p25) ,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          PrimaryText(
                            text:selectedProduct.name!,size: Dimensions.p25,
                          ),
                          SizedBox(height: Dimensions.p15,),
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                  selectedProduct.stars!,
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
                                text: selectedProduct.stars!.toString(),
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
                          SizedBox(height: Dimensions.p20,),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle_sharp,
                                    color:
                                    AppColors.yellowColor,
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
                          SizedBox(height: Dimensions.p20,),
                          PrimaryText(text: "Introduce",color: AppColors.titleColor,),
                          SizedBox(height: Dimensions.p15,),
                          Expanded(
                            child: Container(
                              width: 100.w,
                             // height: 25.h,
                               // color: Colors.redAccent,
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Text(cubit.largeTextHandling(selectedProduct.description!), style: TextStyle(color: AppColors.paraColor,height: 1.35,fontSize: Dimensions.p15),),
                                    if(cubit.isTextLarge)
                                        InkWell(
                                          child: Row(
                                            children: [
                                              Text("SeeMore ",
                                                style: TextStyle(color: AppColors.mainColor,height: 1.2,fontSize: Dimensions.p15,),),
                                            cubit.isSeeMoreOpened?Icon(Icons.arrow_drop_up,color: AppColors.mainColor,size: Dimensions.p20,):Icon(Icons.arrow_drop_down,color: AppColors.mainColor,size: Dimensions.p20,)
                                            ],
                                          ),
                                          onTap:(){
                                                   cubit.changeSeeMore();
                                            },
                                        ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.p20),
                      height: 13.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.p30,),
                        topRight: Radius.circular(Dimensions.p30,),
                      ),
                          color: AppColors.buttonBackgroundColor
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 35.w,
                            height: 7.5.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(Dimensions.p20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(child: Stack(
                                  children: [
                                    SizedBox(
                                      width: Dimensions.p20,
                                      height: Dimensions.p20,
                                    ),
                                    PrimaryText(text: "-",size: Dimensions.p35,color: AppColors.signColor,),
                                  ],
                                )
                                ,onTap: ()=>cubit.decrementQuantityOfSelectedMeal(),),
                                SizedBox(width: Dimensions.p20,),
                                PrimaryText(text: cubit.quantityOfSelectedMeal.toString(),size: Dimensions.p20,color: AppColors.paraColor,),
                                SizedBox(width: Dimensions.p20,),
                                InkWell(child: Stack(
                                  children: [
                                    SizedBox(
                                      width: Dimensions.p20,
                                      height: Dimensions.p20,
                                    ),
                                    PrimaryText(text: "+",size: Dimensions.p20,color: AppColors.signColor,),
                                  ],
                                ),
                                onTap: () {
                                  cubit.incrementQuantityOfSelectedMeal();
                                },),
                              ],),
                          ),

                          InkWell(
                            child: Container(
                              width: 50.w,
                              height: 7.5.h,
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.p10),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(Dimensions.p20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PrimaryText(text: "\$${selectedProduct.price! * cubit.quantityOfSelectedMeal}",color: AppColors.buttonBackgroundColor,size: Dimensions.p18,),
                                  SizedBox(width: Dimensions.p10,),
                                  PrimaryText(text: "Add to cart",color: AppColors.buttonBackgroundColor,size: Dimensions.p18,),
                                ],),
                            ),
                            onTap: ()async {
                              if(cubit.quantityOfSelectedMeal>0) {
                                await cubit.addItemToCart(CartItem(
                                    id: selectedProduct.id,
                                    name: selectedProduct.name,
                                    img: selectedProduct.img,
                                    price: selectedProduct.price,
                                    quantity: cubit.quantityOfSelectedMeal,
                                    isExist: true,
                                    time: DateTime.now().toString()));
                                await cubit.getCartItems();
                              }
                              },
                          ),
                        ],
                      ),
                    ),),
                ],
              ),
            ),
          ),
        )

        );
  }
}
