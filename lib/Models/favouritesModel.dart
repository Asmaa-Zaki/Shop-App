class FavouritesModel
{
  late bool status;
  late String? message;
  late FavouriteData data;

  FavouritesModel.fromJson(Map<String, dynamic> jsonData)
  {
    status= jsonData["status"];
    message= jsonData["message"];
    data= FavouriteData.fromJson(jsonData["data"]);
  }
}

class FavouriteData
{
  late int currentPage;
  List<FavouriteSubData> data=[];

  FavouriteData.fromJson(Map<String, dynamic> jsonData)
  {
    currentPage= jsonData["current_page"];
    jsonData["data"].forEach((element)
    {
      data.add(FavouriteSubData.fromJson(element));
    });
  }
}

class FavouriteSubData
{
  late int id;
  late FavouriteProduct product;

  FavouriteSubData.fromJson(Map<String, dynamic> jsonData)
  {
    id= jsonData["id"];
    product= FavouriteProduct.fromJson(jsonData["product"]);
  }
}

class FavouriteProduct
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  FavouriteProduct.fromJson(Map<String, dynamic> jsonData)
  {
    id= jsonData["id"];
    price= jsonData["price"];
    oldPrice= jsonData["old_price"];
    discount= jsonData["discount"];
    image= jsonData["image"];
    name= jsonData["name"];
    description= jsonData["description"];
  }
}
