import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/search_bloc/states.dart';
import 'package:shopping/consts/consts.dart';
import 'package:shopping/models/favourites_models/add_or_remove_favourites_model.dart';
import 'package:shopping/models/favourites_models/get_favourits_model.dart';
import 'package:shopping/models/search_model.dart';
import 'package:shopping/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() :super(SearchInitialStates());

  static SearchCubit get(context) {
    return BlocProvider.of(context);
  }

  late SearchModel searchModel;

  void searchData({
    required String text,
  }) async {
    emit(SearchLoadingState());
    try {
      Response response = await DioHelper.postData(
          url: "products/search", token: token, data: {
        "text": text,
      });
      searchModel = SearchModel.fromJson(response.data);
      for (var element in searchModel.data.data) {
        favorites.addAll(
            {element.id: element.inFavorites}
        );
        emit(SearchSuccessState());
      }
    }
    catch (e) {
      emit(SearchErrorState());
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
}