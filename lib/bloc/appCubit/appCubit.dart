import 'dart:async';
import 'dart:io';

import 'package:advanced_ecommerce_app/bloc/appCubit/appState.dart';
import 'package:advanced_ecommerce_app/data/models/app_model.dart';
import 'package:advanced_ecommerce_app/data/models/cart_item_model.dart';
import 'package:advanced_ecommerce_app/data/repository/app_repository.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/cart.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/order.dart';
import 'package:advanced_ecommerce_app/presentation/app_layout/screens/profile.dart';
import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../presentation/app_layout/screens/cart_history.dart';
import '../../presentation/app_layout/screens/home.dart';

class AppCubit extends Cubit<AppState>
{
  AppCubit(this.appRepository):super(InitialState());

  final AppRepository appRepository;

  late Box cartBox;
  late Box cartHistoryBox;
  double CarouselSliderIndex = 0;
  bool isTextLarge = false;
  bool isSeeMoreOpened = false;
  //String testText="text eee content of a page when looking at its layout.sometimes by accident, sometimes on purp of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purp text eee content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purp of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', The point of using Lorem Ipsum ";
  //late Product selectedProduct;
  List<Product> popularProducts=[];
  List<Product> recommendedProducts=[];
  int quantityOfSelectedMeal=0;
  bool isLiked=false;
  int totalItemsQuantitiesInCart=0;
  List<CartItem>cartItems=[];
  int totalCheckOut=0;
  List<Widget> pages=[
    const HomeScreen(),
    const OrderScreen(),
    const CartHistory(),
    const ProfileScreen(),
  ];
  int pageIndex=0;
  // int totalSelectedMealPrice = selectedProduct.price??1;
 // Map<int,CartItem> cartItem={};

  void changePageIndex(int index){
    pageIndex=index;
    emit(ChangePageIndex());
  }
  Future<void>getPopularProducts()async{
    appRepository.getPopularProducts().then((products) {
      popularProducts=products.products!;
      emit(GetPopularProducts());
    } );
  }
  Future<void>getRecommendedProducts()async{
    appRepository.getRecommendedProducts().then((products) {
      recommendedProducts=products.products!;
      emit(GetRecommendedProducts());
    } );
  }
  void incrementQuantityOfSelectedMeal(){
    if(quantityOfSelectedMeal<20)
     quantityOfSelectedMeal+=1;
   // totalSelectedMealPrice= selectedProduct.price! * amountOfSelectedMeal;
    emit(IncrementAmountOfSelectedMeal());
  }
  void decrementQuantityOfSelectedMeal(){
    if(quantityOfSelectedMeal>0)
    quantityOfSelectedMeal-=1;
  //  totalSelectedMealPrice= selectedProduct.price! * amountOfSelectedMeal;
    emit(DecrementAmountOfSelectedMeal());
  }
  void changeIsLiked(){
    isLiked=!isLiked;
    emit(ChangeIsLiked());
  }
  String largeTextHandling(String txt){
   if(txt.length>250&& !isSeeMoreOpened)
   {
     isTextLarge =true;
     emit(LargeTextHandlingState1());
     return txt.substring(0,250)+"...";
   }else if(txt.length>250 && isSeeMoreOpened){
     isTextLarge =true;
     emit(LargeTextHandlingState2());
     return txt;
   }
   else{
     isTextLarge =false;
     emit(LargeTextHandlingState3());
     return txt;
   }

 }
  void changeSeeMore() {
   isSeeMoreOpened =!isSeeMoreOpened;
   emit(ChangeSeeMoreState());
 }
  void updateCarouselSlider(double index){
    CarouselSliderIndex =index;
    emit(UpdateCarouselSliderState());
  }

  //***************CART********************

  Future<void> openBoxes()async{
   cartBox= await Hive.openBox(Constants.cartBox);
   cartHistoryBox= await Hive.openBox(Constants.cartHistoryBox);
   emit(OpenBoxes());
  }
  Future<void>addItemToCart(CartItem cartItem)async {
    if(!cartBox.isOpen)
      await openBoxes();
    if(cartBox.containsKey(cartItem.id.toString())) {
      await updateCartItem(cartItem);
    } else {
      cartBox.put(cartItem.id.toString(), cartItem.toJson());
    }
    totalCartItems();
    emit(AddItemToCart());
  }
  Future<CartItem> getCartItem(String id)async{
    emit(GetCartItem());
  return CartItem.fromJson(await cartBox.get(id));
  }
  Future<void> updateCartItem(CartItem cartItem)async{
    CartItem? item =await getCartItem(cartItem.id.toString());
     cartBox.put(cartItem.id.toString(), CartItem(id:item.id,
        name: item.name,
        price: item.price,
        img: item.img,
        quantity:  cartItem.quantity! ,// item.quantity! +
        isExist: true,
        time: DateTime.now().toString(),
    ).toJson());
     emit(UpdateCartItem());
    }
  Future<void> initDetailsPage(Product product)async{
    if(cartBox.containsKey(product.id.toString())){
     CartItem cartItem= await getCartItem(product.id.toString());
     quantityOfSelectedMeal=cartItem.quantity!;
     emit(InitDetailsPage());
    }
    else{
      quantityOfSelectedMeal=0;
      emit(InitDetailsPage());
    }
  }
  void totalCartItems(){
    totalItemsQuantitiesInCart=0;
   Map<dynamic,dynamic>map= cartBox.toMap();
   map.values.toList().forEach((element) {totalItemsQuantitiesInCart+=int.parse(element["quantity"].toString());
  });
   emit(TotalCartItems());
  }
  Future<void> getCartItems()async{
    cartItems=[];
    if(!cartBox.isOpen)
      await openBoxes();
    if(cartBox.isNotEmpty) {
      Map<dynamic, dynamic> map = cartBox.toMap();
     map.values.toList().forEach((element) {
        cartItems.add(CartItem.fromJson(element));
      });
    }
    calculateTotalCheckOut();
    //else
    //  box.put(cartItem.id.toString(), cartItem.toJson());
    emit(GetCartItems());
  }
  void calculateTotalCheckOut(){
    int? quantity=0;
    int? price=0;
    totalCheckOut=0;
    if(cartItems.isNotEmpty) {
      cartItems.forEach((element) {
      quantity = element.quantity ?? 0;
      price = element.price ?? 0;
      totalCheckOut+=(quantity! * price!);
    });
    }
    emit(CalculateTotalCheckOut());
  }
  int changeCartItemQuantity(int quantity,bool increment){
    if(increment) {
        if(quantity<20) {
          emit(ChangeCartItemQuantity());
          return quantity+1;
        } else {
          emit(ChangeCartItemQuantity());
          return quantity;
        }
      }else{
      if(quantity>0) {
        emit(ChangeCartItemQuantity());
        return quantity-1;
      } else {
        emit(ChangeCartItemQuantity());
        return quantity;
      }
    }

  }
  Future<void>deleteCartItem(int id)async{
    if(!cartBox.isOpen)
      await openBoxes();
    if(cartBox.containsKey(id.toString())) {
      await cartBox.delete(id.toString());
    }
    emit(DeleteCartItem());
  }
  Future<void>deleteAllCartItems()async{
    if(!cartBox.isOpen)
      await openBoxes();
      await cartBox.clear();
    emit(DeleteCartItem());
  }

  //***************CART History********************


}