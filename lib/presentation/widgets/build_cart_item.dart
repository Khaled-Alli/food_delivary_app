import 'package:advanced_ecommerce_app/bloc/appCubit/appCubit.dart';
import 'package:advanced_ecommerce_app/bloc/appCubit/appState.dart';
import 'package:advanced_ecommerce_app/data/models/cart_item_model.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/recommended_meal_details.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/secondary_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../utiles/app_router.dart';
import '../../utiles/colors.dart';
import '../../utiles/constants.dart';
import '../../utiles/my_icon_icons.dart';
class BuildCartItem extends StatelessWidget {

  int index;
  BuildCartItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var cubit= BlocProvider.of<AppCubit>(context);
    return BlocBuilder<AppCubit,AppState>(builder: (context,_)=>
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.p15),
                  child: Container(
                    width: 30.w,
                    height: 12.h,
                    child: Image.network(Constants.baseURL+Constants.uploads+cubit.cartItems[index].img.toString(),fit: BoxFit.cover,),
                  ),

                ),
                Container(
                  width: 61.w,
                  height: 10.h,
                  padding: EdgeInsets.only(left: Dimensions.p10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight:Radius.circular(Dimensions.p15,),bottomRight:Radius.circular(Dimensions.p15,),  ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: Dimensions.p5),
                        child: PrimaryText(
                          text: cubit.cartItems[index].name.toString(),
                          size: Dimensions.p15,
                        ),
                      ),
                      Row(
                        children: [
                          PrimaryText(text:"\$${(cubit.cartItems[index].price! * cubit.cartItems[index].quantity!).toString()}",color: Colors.red,size: Dimensions.p15,),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                ,onTap: ()async{
                                 cubit.cartItems[index].quantity= cubit.changeCartItemQuantity(cubit.cartItems[index].quantity!, false);
                               await  cubit.updateCartItem(CartItem(
                                   id: cubit.cartItems[index].id!,
                                   name: cubit.cartItems[index].name!,
                                   price: cubit.cartItems[index].price!,
                                   img: cubit.cartItems[index].img!,
                                   isExist: cubit.cartItems[index].isExist!,
                                   quantity: cubit.cartItems[index].quantity!,
                                 ));
                                 if(cubit.cartItems[index].quantity==0){
                                   cubit.deleteCartItem(cubit.cartItems[index].id!);
                                 }
                                 await  cubit.getCartItems();
                                 cubit.totalCartItems();
                                },),
                              SizedBox(width: Dimensions.p20,),
                              PrimaryText(text: cubit.cartItems[index].quantity.toString(),size: Dimensions.p15,color: AppColors.paraColor,),
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
                                onTap: ()async {
                                  cubit.cartItems[index].quantity= cubit.changeCartItemQuantity(cubit.cartItems[index].quantity!, true);
                                  await   cubit.updateCartItem(CartItem(
                                    id: cubit.cartItems[index].id!,
                                    name: cubit.cartItems[index].name!,
                                    price: cubit.cartItems[index].price!,
                                    img: cubit.cartItems[index].img!,
                                    isExist: cubit.cartItems[index].isExist!,
                                    quantity: cubit.cartItems[index].quantity!,
                                  ));
                                  await  cubit.getCartItems();
                                  cubit.totalCartItems();
                                },),
                            ],),
                        ],
                      ),
                    ],
                  ),
                ),
              ],),
          );
  }
}
