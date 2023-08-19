import 'package:shopping/models/poduct_data/product_data.dart';

class GetFavouritesModel{
  late bool status;
  late GetFavouritesDataModel data;
  GetFavouritesModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    data=GetFavouritesDataModel.fromJson(json["data"]);
  }
}
class GetFavouritesDataModel{
  List<FavoriteData>data=[];

  GetFavouritesDataModel.fromJson(Map<String,dynamic>json){
    json["data"].forEach((element){
      data.add(FavoriteData.fromJson(element));
    });
  }
}

class FavoriteData extends ProductData{

  FavoriteData.fromJson(Map<String,dynamic>json) : super.fromJson(json){
    id=json["product"]["id"];
    price=json["product"]["price"];
    oldPrice=json["product"]["old_price"];
    discount=json["product"]["discount"];
    image=json["product"]["image"];
    name=json["product"]["name"];
    description=json["product"]["description"];
  }
}