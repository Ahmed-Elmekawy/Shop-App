import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/shop_bloc/states.dart';
import 'package:shopping/consts/consts.dart';
import 'package:shopping/models/categories_model.dart';
import 'package:shopping/models/favourites_models/add_or_remove_favourites_model.dart';
import 'package:shopping/models/favourites_models/get_favourits_model.dart';
import 'package:shopping/models/home_model.dart';
import 'package:shopping/models/login_model.dart';
import 'package:shopping/models/logout_model.dart';
import 'package:shopping/modules/shop_layout/categories_screen.dart';
import 'package:shopping/modules/shop_layout/favourites_screen.dart';
import 'package:shopping/modules/shop_layout/home_screen.dart';
import 'package:shopping/modules/shop_layout/settings_screen.dart';
import 'package:shopping/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() :super(ShopInitialState());

  static ShopCubit get(context) {
    return BlocProvider.of(context);
  }
  int currentIndex=0;
  List<Widget>items=[
    const Home(),
    const Categories(),
    const Favourites(),
    const Settings()
  ];

  void changeBottomNav(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }

  LoginModel? loginModel;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  LogoutModel? logoutModel;

  void getHomeData()async{
    emit(HomeLoadingState());
    try{
      Response response =await DioHelper.getData(url: "home", token: token);
      homeModel=HomeModel.fromJson(response.data);
      for (var element in homeModel!.data.products) {
        favorites.addAll(
            {element.id:element.inFavorites}
        );
      }
      emit(HomeSuccessState());
    }
    catch(e){
      emit(HomeErrorState());
    }
  }

  void getCategoriesData()async{
    emit(CategoriesLoadingState());
    try{
      Response response =await DioHelper.getData(url: "categories", token: token);
      categoriesModel=CategoriesModel.fromJson(response.data);
      emit(CategoriesSuccessState());
    }
    catch(e){
      emit(CategoriesErrorState());
    }
  }

  void getFavouritesData()async{
    emit(GetFavouritesLoadingState());
    try{
      Response response =await DioHelper.getData(url: "favorites", token: token);
      getFavouritesModel=GetFavouritesModel.fromJson(response.data);
      emit(GetFavouritesSuccessState());
    }
    catch(e){
      emit(GetFavouritesErrorState());
    }
  }

  void addOrRemoveFavouritesData({required int productId})async{
    favorites[productId]=!favorites[productId]!;
    emit((AddOrRemoveFavouritesState()));
    try{
      Response response =await DioHelper.postData(url: "favorites", token: token, data: {
        "product_id":productId
      });
      addOrRemoveFavouritesModel=AddOrRemoveFavouritesModel.fromJson(response.data);
      if(!addOrRemoveFavouritesModel.status)
        {
          favorites[productId]=!favorites[productId]!;
        }
      else{
        getFavouritesData();
      }
      emit(AddOrRemoveFavouritesSuccessState(addOrRemoveFavouritesModel));
    }
    catch(e){
      favorites[productId]=!favorites[productId]!;
      emit(AddOrRemoveFavouritesErrorState());
    }
  }

  void getProfileData()async{
    emit(GetProfileLoadingState());
    try{
      Response response =await DioHelper.getData(url: "profile", token: token);
      loginModel=LoginModel.fromJson(response.data);
      emit(GetProfileSuccessState());
    }
    catch(e){
      emit(GetProfileErrorState());
    }
  }

  void updateProfileData({
    required String name,
    required String phone,
    required String email,
})async{
    emit(UpdateProfileLoadingState());
    try{
      Response response =await DioHelper.putData(url: "update-profile", token: token,data: {
        "name": name,
        "phone": phone,
        "email": email
      });
      loginModel=LoginModel.fromJson(response.data);
      emit(UpdateProfileSuccessState(loginModel!));
    }
    catch(e){
      emit(UpdateProfileErrorState());
    }
  }

  void logout()async{
    emit(LogoutLoadingState());
    try{
      Response response =await DioHelper.postData(url: "logout", token: token,data: {
        "fcm_token": "SomeFcmToken"
      });
      logoutModel=LogoutModel.fromJson(response.data);
      currentIndex=0;
      emit(LogoutSuccessState(logoutModel!));
    }
    catch(e){
      emit(LogoutErrorState());
    }
  }
}