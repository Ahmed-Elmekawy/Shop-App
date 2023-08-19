import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/shop_bloc/cubit.dart';
import 'package:shopping/bloc/shop_bloc/states.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

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
            body: ConditionalBuilder(
              condition: cubit.categoriesModel!=null,
              builder:(context) => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey,
                              width: 5),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Image(image: NetworkImage(
                        cubit.categoriesModel!.data.data[index].image
                      ),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Text(cubit.categoriesModel!.data.data[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(onPressed:() {

                    },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ),
                  separatorBuilder:(context, index) => const Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  itemCount: cubit.categoriesModel!.data.data.length
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            )
        );
      },
    );
  }
}
