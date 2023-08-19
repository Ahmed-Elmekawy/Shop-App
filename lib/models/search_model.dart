import 'poduct_data/product_data.dart';

class SearchModel{
  bool? status;
  late SearchDataModel data;
  SearchModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    data=SearchDataModel.fromJson(json["data"]);
  }
}
class SearchDataModel{
  List<SearchData>data=[];

  SearchDataModel.fromJson(Map<String,dynamic>json){
    json["data"].forEach((element){
      data.add(SearchData.fromJson(element));
    });
  }
}

class SearchData extends ProductData{

  late bool inFavorites;
  late bool inCart;
  SearchData.fromJson(Map<String,dynamic>json) : super.fromJson(json){
    id=json["id"];
    price=json["price"];
    oldPrice=json["old_price"];
    discount=json["discount"];
    image=json["image"];
    name=json["name"];
    description=json["description"];
    inFavorites=json["in_favorites"];
    inCart=json["in_cart"];
  }
}