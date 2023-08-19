import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/shop_bloc/cubit.dart';
import 'package:shopping/bloc/shop_bloc/states.dart';
import 'package:shopping/consts/consts.dart';
import 'package:shopping/models/categories_model.dart';
import 'package:shopping/models/home_model.dart';
import 'package:shopping/modules/shop_layout/search_screen.dart';
import 'package:shopping/shared/components.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {
          if(state is AddOrRemoveFavouritesSuccessState){
            if(!state.addOrRemoveFavouritesModel.status) {
              showToast(msg: state.addOrRemoveFavouritesModel.message, state: ToastStates.error);
            }
          }
        },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title:const Text("Salla",
              style: TextStyle(
                fontSize: 25,
                fontFamily: "PermanentMarker",
                color: Colors.black
              ),
            ),
            actions: [
              IconButton(onPressed: () {
                navigate(context,const Search());
              },
                  icon: const Icon(
                      Icons.search_outlined
                  )
              )
            ],
          ),
          body:ConditionalBuilder(
            condition:ShopCubit.get(context).homeModel!=null&&ShopCubit.get(context).categoriesModel!=null,
            builder: (context) => bannerAndProducts(context,
                homeModel:ShopCubit.get(context).homeModel!,
                categoriesModel: ShopCubit.get(context).categoriesModel),
            fallback:(context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
Widget bannerAndProducts(context,{required HomeModel homeModel,CategoriesModel? categoriesModel}){
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: List.generate(homeModel.data.banners.length, (index) => Image(image:
            NetworkImage(homeModel.data.banners[index].image),
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            ),
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1,
            )
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Categories",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontFamily: "PermanentMarker"
              ),),
              const SizedBox(height: 10,),
              SizedBox(
                height: 120,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder:(context, index) =>Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Image(image: NetworkImage(
                          categoriesModel.data.data[index].image
                        ),
                          height: 120,
                          width: 120,
                        ),
                        Container(
                            width: 120,
                            color: Colors.black.withOpacity(0.8),
                            child: Text(categoriesModel.data.data[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            )
                        ),
                      ],
                    ) ,
                    separatorBuilder: (context, index) => const SizedBox(width: 10,),
                    itemCount:categoriesModel!.data.data.length
                ),
              ),
              const SizedBox(height: 20,),
              const Text("New Products",
                style: TextStyle(
                  color: Colors.blue,
                    fontSize: 20,
                    fontFamily: "PermanentMarker"
                ),),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            childAspectRatio: 1/1.5,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children:
              List.generate(homeModel.data.products.length,
                      (index) => productBuilder(context,homeModel.data.products[index])
              ),
          ),
        )
      ],
    ),
  );
}

Widget productBuilder(context,ProductsModel productsModel){
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage(
                productsModel.image
              ),
                width: double.infinity,
                height:150,
              ),
              if(productsModel.discount!=0)
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text("discount".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white
                  ),
                  )
              )
            ],
          ),
          const SizedBox(height: 5,),
          Text(productsModel.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            height: 1.3,
          ),
          ),
          Row(
            children: [
              Text("${productsModel.price.round()}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(width: 5,),
              const Text("L.E",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,

                ),
              ),
              const SizedBox(width: 10,),
              if(productsModel.discount!=0)
              Text("${productsModel.oldPrice.round()}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const Spacer(),
              IconButton(onPressed: () {
                ShopCubit.get(context).addOrRemoveFavouritesData(productId: productsModel.id);
              },
                  icon: CircleAvatar(
                    backgroundColor: favorites[productsModel.id]==true?Colors.blue:Colors.grey,
                    child: const Icon(
                      size: 14,
                      Icons.favorite_border_outlined,
                      color: Colors.white,
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    ),
  );
}