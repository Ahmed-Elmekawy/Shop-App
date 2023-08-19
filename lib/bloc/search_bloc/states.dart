import 'package:shopping/models/favourites_models/add_or_remove_favourites_model.dart';

abstract class SearchStates{}

class SearchInitialStates extends SearchStates{}

class SearchLoadingState extends SearchStates{}

class SearchSuccessState extends SearchStates{}

class SearchErrorState extends SearchStates{}

class GetFavouritesLoadingState extends SearchStates{}

class GetFavouritesSuccessState extends SearchStates{}

class GetFavouritesErrorState extends SearchStates{}

class AddOrRemoveFavouritesState extends SearchStates{}

class AddOrRemoveFavouritesSuccessState extends SearchStates{
  AddOrRemoveFavouritesModel addOrRemoveFavouritesModel;
  AddOrRemoveFavouritesSuccessState(this.addOrRemoveFavouritesModel);
}

class AddOrRemoveFavouritesErrorState extends SearchStates{}