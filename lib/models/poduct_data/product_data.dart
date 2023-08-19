abstract class ProductData{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image="";
  String name="";
  String description="";

  ProductData.fromJson(Map<String,dynamic>json);
}