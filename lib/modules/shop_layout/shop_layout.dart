import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/shop_bloc/cubit.dart';
import 'package:shopping/bloc/shop_bloc/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  ShopCubit()..getHomeData()..getCategoriesData()..getFavouritesData()..getProfileData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var cubit=ShopCubit.get(context);
          return Scaffold(
            appBar:null,
            body: cubit.items[cubit.currentIndex],
            bottomNavigationBar:BottomNavigationBar(
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
                currentIndex: cubit.currentIndex,
              items:const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: "Home"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps_outlined),
                    label: "Categories"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outlined),
                    label: "Favorites"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: "Settings"
                ),
              ]
            ),

          );
        },
      ),
    );
  }
}
