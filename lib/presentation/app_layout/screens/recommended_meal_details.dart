import 'package:advanced_ecommerce_app/bloc/appCubit/appCubit.dart';
import 'package:advanced_ecommerce_app/bloc/appCubit/appState.dart';
import 'package:advanced_ecommerce_app/data/models/app_model.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/cart_total_quantity.dart';
import 'package:advanced_ecommerce_app/utiles/app_router.dart';
import 'package:advanced_ecommerce_app/utiles/colors.dart';
import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:advanced_ecommerce_app/utiles/my_icon_icons.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/cart_item_model.dart';
import '../../widgets/circled_botton_with_icon.dart';
import 'cart.dart';

class RecommendedMealDetails extends StatelessWidget {
  Product selectedProduct;
   RecommendedMealDetails({Key? key,required this.selectedProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AppCubit>(context);
    return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) => Scaffold(
              body: Padding(
                padding:EdgeInsets.only(top:Dimensions.statusBarH, ) ,
                child: CustomScrollView(
                  //  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      toolbarHeight: Dimensions.p80,
                      title: Row(children: [
                        CircledBottonWithIcon(icon: Icons.clear, fun: ()=>AppRouter.pop(context)),
                         Spacer(),
                        InkWell(
                          child: Stack(
                            children: [

                              CircledBottonWithIcon(icon: MyIcon.cart, fun: (){
                                AppRouter.goTo(context, const CartScreen());
                              }),
                              if(cubit.totalItemsQuantitiesInCart>0)
                              CartTotalQuantity(totalQuantity: cubit.totalItemsQuantitiesInCart, backgroundColor: AppColors.mainColor, textColor: Colors.white)
                            ],
                          ),
                          onTap: (){
                            AppRouter.goTo(context, const CartScreen());
                          },
                        ),
                      ],),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(Dimensions.p30),
                        child: Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Dimensions.p15),
                                topRight: Radius.circular(Dimensions.p15),
                              )),
                          padding: EdgeInsets.symmetric(vertical: Dimensions.p10),
                          child: Center(
                              child: PrimaryText(
                            text: selectedProduct.name!,
                                size: Dimensions.p25,
                          )),
                        ),
                      ),
                      pinned: true,
                      expandedHeight: 38.5.h,
                      backgroundColor: AppColors.yellowColor,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          Constants.baseURL+Constants.uploads+selectedProduct.img!,
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
                                 height: 38.5.h,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                          width: 100.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: 100.w,
                      //  height: 25.h,
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.p15),
                        // color: Colors.redAccent,
                        child: Column(
                          children: [
                            Text(cubit.largeTextHandling(selectedProduct.description!), style: TextStyle(color: AppColors.paraColor,height: 1.65,fontSize: Dimensions.p17),),
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
                  ],
                ),
              ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: Dimensions.p15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircledBottonWithIcon(icon: Icons.remove, fun: ()=>cubit.decrementQuantityOfSelectedMeal(),iconColor: Colors.white,backgroundColor: AppColors.mainColor,),
                    PrimaryText(text: "\$ ${selectedProduct.price!}  X  ${cubit.quantityOfSelectedMeal!}"),
                    CircledBottonWithIcon(icon: Icons.add, fun:()=>cubit.incrementQuantityOfSelectedMeal(),iconColor: Colors.white,backgroundColor: AppColors.mainColor,),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.p20),
                height: 15.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.p30,),
                  topRight: Radius.circular(Dimensions.p30,),
                ),
                    color: AppColors.buttonBackgroundColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 18.w,
                        height: 7.5.h,
                        decoration: BoxDecoration(
                          color:cubit.isLiked? Colors.white:AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.p20),
                        ),
                        child: Icon(Icons.favorite,color:cubit.isLiked?AppColors.mainColor:Colors.white,size: Dimensions.p30,),
                      ),
                      onTap: ()=>cubit.changeIsLiked(),
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
                      onTap: ()async{
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
              ),
            ],
          ),
            ),
        listener: (context, state) {});
  }
}
