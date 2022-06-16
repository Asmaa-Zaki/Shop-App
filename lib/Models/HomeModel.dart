class ShopHomeModel
{
  late bool status;
  late String?  message;
  late HomeDataModel data;

  ShopHomeModel.fromJson(Map<String, dynamic> jsonData)
  {
      status= jsonData['status'];
      message= jsonData['message'];
      data= HomeDataModel.fromJson(jsonData['data']);
  }
}

class HomeDataModel
{
     List<BannerModel> banners= [];
     List<ProductsModel> products= [];

    HomeDataModel.fromJson(Map<String, dynamic> jsonData)
    {
      jsonData['banners'].forEach((element){
        banners.add(BannerModel.fromJson(element));
      });
      jsonData['products'].forEach((element){
          products.add(ProductsModel.formJson(element));
      });
    }
}

class BannerModel
{
  late int id;
  late String image;

  BannerModel.fromJson(Map<String, dynamic> jsonData)
  {
    id= jsonData['id'];
    image= jsonData['image'];
  }
}

class ProductsModel
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  late List<dynamic> images;
  late bool inFavorites;
  late bool inCart;

  ProductsModel.formJson(Map<String, dynamic> jsonData)
  {
    id= jsonData["id"];
    price= jsonData["price"];
    oldPrice= jsonData["old_price"];
    discount= jsonData["discount"];
    image= jsonData["image"];
    name= jsonData["name"];
    description= jsonData["description"];
    images= jsonData["images"];
    inFavorites= jsonData["in_favorites"];
    inCart= jsonData["in_cart"];
  }
}