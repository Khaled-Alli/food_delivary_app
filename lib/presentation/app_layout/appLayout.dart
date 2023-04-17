import 'package:advanced_ecommerce_app/bloc/appCubit/appCubit.dart';
import 'package:advanced_ecommerce_app/bloc/appCubit/appState.dart';
import 'package:advanced_ecommerce_app/presentation/widgets/primary_text.dart';
import 'package:advanced_ecommerce_app/utiles/colors.dart';
import 'package:advanced_ecommerce_app/utiles/constants.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  void initState() {

   // BlocProvider.of<AppCubit>(context).timer();
    _controller = PersistentTabController(initialIndex:BlocProvider.of<AppCubit>(context).pageIndex);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  late PersistentTabController _controller;
  @override
  Widget build(BuildContext context) {
    var cubit=BlocProvider.of<AppCubit>(context);

    return BlocBuilder<AppCubit,AppState>(builder: (context,state)=>
        Scaffold(
      body:
    /*  OfflineBuilder(
          connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if(connected){
              return cubit.pages[cubit.pageIndex];
            }else{
            return Center(child: PrimaryText(text: "Please check internet connection ",),);
            }

          },
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
           Text(
            'There are no bottons to push :)',
          ),
          Text(
            'Just turn off your internet.',
          ),
        ],
      ),
      ),*/
           cubit.pages[cubit.pageIndex],

      bottomNavigationBar:
      BottomNavigationBar(
        backgroundColor:Colors.white,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.paraColor ,
        showSelectedLabels: false,
        showUnselectedLabels: false,
       // enableFeedback: false,
        onTap:(index){ cubit.changePageIndex(index);},
        currentIndex: cubit.pageIndex,
        items:  [
          BottomNavigationBarItem(icon:Icon(Icons.home_outlined,size: Dimensions.p20,),label: ""),
          BottomNavigationBarItem(icon:Icon(Icons.archive_outlined,size: Dimensions.p20,),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined,size: Dimensions.p20,),label: ""),
          BottomNavigationBarItem(icon:Icon(Icons.person,size: Dimensions.p20,),label: ""),
        ],

      ),
          /*  PersistentTabView(
              context,
              controller: _controller,
              screens: cubit.pages,

              items: [
          PersistentBottomNavBarItem(
        icon:  Icon(Icons.home_outlined,size: Dimentions.p20,),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.paraColor,
        ),
          PersistentBottomNavBarItem(
        icon:  Icon(Icons.archive_outlined,size: Dimentions.p20,),
        activeColorPrimary:AppColors.mainColor,
        inactiveColorPrimary: AppColors.paraColor,
        ),
          PersistentBottomNavBarItem(
            icon:  Icon(Icons.shopping_cart_outlined,size: Dimentions.p20,),
            activeColorPrimary: AppColors.mainColor,
            inactiveColorPrimary:AppColors.paraColor,
          ),
          PersistentBottomNavBarItem(
            icon:  Icon(Icons.person,size: Dimentions.p20,),
            activeColorPrimary:AppColors.mainColor,
            inactiveColorPrimary:AppColors.paraColor,
          ),
        ],

              confineInSafeArea: true,
              backgroundColor: Colors.white, // Default is Colors.white.
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.
              hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(10.0),
                colorBehindNavBar: Colors.white,
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 150),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 150),
              ),
              navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
            ),*/
    ));
  }
}
