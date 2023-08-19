import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/search_bloc/cubit.dart';
import 'package:shopping/bloc/search_bloc/states.dart';
import 'package:shopping/shared/components.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey =GlobalKey<FormState>();
    TextEditingController searchController=TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit=SearchCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                leading: const BackButton(color: Colors.black),
              ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    customField(
                        onFieldSubmitted:(String text) {
                          if(formKey.currentState!.validate()) {
                            cubit.searchData(text: text);
                          }
                        },
                        prefixIcon: Icons.search_outlined,
                        labelText: "Search",
                        controller: searchController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "enter text to search";
                          }
                          return null;
                        }
                        ),
                    const SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 16,),
                    if(state is SearchSuccessState||state is AddOrRemoveFavouritesState||state is GetFavouritesLoadingState||state is GetFavouritesSuccessState||state is AddOrRemoveFavouritesSuccessState)
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder:(context, index) =>builderProduct(cubit,
                                productData: cubit.searchModel.data.data[index],
                                isFavourite: false
                            ),
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            itemCount: cubit.searchModel.data.data.length
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
