class LogoutModel{
  late bool status;
  late String message;
  LogoutModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}