
import 'package:shopping/models/favourites_models/add_or_remove_favourites_model.dart';
import 'package:shopping/models/login_model.dart';
import 'package:shopping/models/logout_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class HomeLoadingState extends ShopStates{}

class HomeSuccessState extends ShopStates{}

class HomeErrorState extends ShopStates{}

class CategoriesLoadingState extends ShopStates{}

class CategoriesSuccessState extends ShopStates{}

class CategoriesErrorState extends ShopStates{}

class GetFavouritesLoadingState extends ShopStates{}

class GetFavouritesSuccessState extends ShopStates{}

class GetFavouritesErrorState extends ShopStates{}

class AddOrRemoveFavouritesState extends ShopStates{}

class AddOrRemoveFavouritesSuccessState extends ShopStates{
  AddOrRemoveFavouritesModel addOrRemoveFavouritesModel;
  AddOrRemoveFavouritesSuccessState(this.addOrRemoveFavouritesModel);
}

class AddOrRemoveFavouritesErrorState extends ShopStates{}

class UpdateProfileLoadingState extends ShopStates{}

class UpdateProfileSuccessState extends ShopStates{
  LoginModel loginModel;
  UpdateProfileSuccessState(this.loginModel);
}

class UpdateProfileErrorState extends ShopStates{}

class GetProfileLoadingState extends ShopStates{}

class GetProfileSuccessState extends ShopStates{}

class GetProfileErrorState extends ShopStates{}

class LogoutLoadingState extends ShopStates{}

class LogoutSuccessState extends ShopStates{
  LogoutModel logoutModel;
  LogoutSuccessState(this.logoutModel);
}

class LogoutErrorState extends ShopStates{}

