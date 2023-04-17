import 'package:advanced_ecommerce_app/presentation/app_layout/screens/home.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/cart_total_quantity.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/circled_botton_with_icon.dart';
import 'package:advanced_ecommerce_app/utiles/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../bloc/appCubit/appCubit.dart';
import '../../../bloc/appCubit/appState.dart';
import '../../../utiles/colors.dart';
import '../../../utiles/constants.dart';
import '../../widgets/build_cart_item.dart';
import '../../widgets/empty_cart.dart';
import '../../widgets/primary_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AppCubit>(context);
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) =>
            Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding:EdgeInsets.only(top:Dimensions.statusBarH, ) ,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.p15,
                      right: Dimensions.p15,
                      top: Dimensions.p25,
                      ),
                  child: Row(children: [
                    if(cubit.pageIndex==0)
                    CircledBottonWithIcon(icon: Icons.arrow_back_ios_new, fun: (){AppRouter.pop(context);},backgroundColor: AppColors.mainColor,iconColor: Colors.white,),
                    const Spacer(),
                     CircledBottonWithIcon(icon: Icons.home_outlined, fun: (){
                       AppRouter.pop(context);
                       AppRouter.pop(context);
                       },backgroundColor: AppColors.mainColor,iconColor: Colors.white,),
                    SizedBox(width: Dimensions.p45,),
                    Stack(
                      children: [
                        CircledBottonWithIcon(icon: Icons.shopping_cart_outlined, fun: (){},backgroundColor: AppColors.mainColor,iconColor: Colors.white,),
                      if(cubit.totalItemsQuantitiesInCart>0)
                        CartTotalQuantity(totalQuantity: cubit.totalItemsQuantitiesInCart, backgroundColor: Colors.white, textColor: Colors.black)
                      ],
                    ),
                  ],),
                ),
                SizedBox(height: Dimensions.p15,),
               if(cubit.cartItems.isEmpty)
                 const EmptyCart(),
               if(cubit.cartItems.isNotEmpty)
                  Expanded(
                  child: SingleChildScrollView(
                    physics:const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.p15,
                          right: Dimensions.p15,
                        //  top: Dimentions.p15,

                         ),
                      child: Column(
                        children: [
                          SizedBox(height: 1.h,),
                          ListView.separated(
                            itemBuilder:(context,index)=> BuildCartItem( index: index),
                            separatorBuilder: (context,index)=> SizedBox(height: Dimensions.p10,),
                            itemCount: cubit.cartItems.length,
                            shrinkWrap: true,
                            physics:const NeverScrollableScrollPhysics(),
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
                if(cubit.cartItems.isNotEmpty)
                  Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.p15,
                      right: Dimensions.p15,
                      ),
                  height: 12.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                   //   border:BorderDirectional(top: BorderSide(width: 1,),) ,
                      borderRadius: BorderRadius.only(
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
                        child: Center(child: PrimaryText(text:"\$${cubit.totalCheckOut.toString()}",size: Dimensions.p20,color: AppColors.paraColor,)),
                      ),

                      InkWell(
                        child: Container(
                          width: 35.w,
                          height: 7.5.h,
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.p10),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(Dimensions.p20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryText(text: "Check out",color: AppColors.buttonBackgroundColor,size: Dimensions.p18,),
                            ],),
                        ),
                        onTap: () {
/*
                          cubit.addItemToCart(CartItem(id: selectedProduct.id,
                              name: selectedProduct.name,
                              img: selectedProduct.img,
                              quantity: cubit.quantityOfSelectedMeal,
                              isExist: true,
                              time: DateTime.now().toString()));

 */
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ),
        listener: (context, state) {});
  }
}
