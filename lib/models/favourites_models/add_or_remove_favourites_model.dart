class AddOrRemoveFavouritesModel{
  late bool status;
  late String message;
  AddOrRemoveFavouritesModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}