import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/shop_bloc/cubit.dart';
import 'package:shopping/bloc/shop_bloc/states.dart';
import 'package:shopping/consts/consts.dart';
import 'package:shopping/shared/components.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title:const Text("Salla",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: "PermanentMarker",
                    color: Colors.black
                ),
              ),
            ),
            body:ConditionalBuilder(
              condition: getFavouritesModel!=null,
              builder:(context) {
                return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => builderProduct(cubit,productData: getFavouritesModel!.data.data[index]),
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: getFavouritesModel!.data.data.length
                );
              },
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            )
        );
      },
    );
  }
}
