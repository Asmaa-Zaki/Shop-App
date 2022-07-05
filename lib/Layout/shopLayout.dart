import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/Block/Cubit.dart';
import 'package:shop_app/Modules/Block/States.dart';
import 'package:shop_app/Modules/CategoriesScreen.dart';
import 'package:shop_app/Modules/LoginScreen.dart';
import 'package:shop_app/Modules/favouriteScreen.dart';
import 'package:shop_app/Modules/productScreen.dart';
import 'package:shop_app/Modules/settingScreen.dart';
import 'package:shop_app/Shared/Components.dart';
import 'package:shop_app/Shared/Local/CacheHelper.dart';
import '../Modules/searchScreen.dart';
import '../Shared/constants.dart';

class ShopLayout extends StatefulWidget {
  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
        create: (context) {
          return ShopCubit()
            ..loadHome()
            ..loadCategories()
            ..getFavourites()
            ..getProfileData();
        },
        child: BlocConsumer<ShopCubit, ShopStates>(
          builder: (BuildContext context, Object? state) {
            List<Widget> pages = [
              ProductScreen(),
              CategoriesScreen(),
              FavouriteScreen(),
              SettingScreen()
            ];
            return Scaffold(
              appBar: AppBar(
                backgroundColor: defaultColor,
                title: const Text("ShopApp"),
                actions: [
                  IconButton(
                      onPressed: () {
                        navigateTo(context, SearchScreen());
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              body: SafeArea(child: pages[currentIndex]),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: defaultColor,
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps_sharp), label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favourites"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Setting"),
                ],
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                    print(currentIndex);
                  });
                },
              ),
            );
          },
          listener: (context, states) {},
        ));
  }

  TextButton buildTextButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        CacheHelper.removeKey(key: "token").then((value) => buildShopToast(
                message: "Logout done Successfully", state: LoginState.success)
            .then((value) => navigateAndReplace(context, LoginScreen())));
      },
      child: const Text("LogOut"),
    );
  }
}
