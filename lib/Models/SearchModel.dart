class SearchModel
{
  late bool status;
  late String? message;
  late SearchData data;

  SearchModel.fromJson(Map<String, dynamic> jsonData)
  {
    status= jsonData["status"];
    message= jsonData["message"];
    data= SearchData.fromJson(jsonData["data"]);
  }
}

class SearchData
{
  late int currentPage;
  List<SearchSubData> data=[];

  SearchData.fromJson(Map<String, dynamic> jsonData)
  {
    currentPage= jsonData["current_page"];
    jsonData["data"].forEach((element)
    {
      data.add(SearchSubData.fromJson(element));
    });
  }
}

class SearchSubData
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int? discount;
  late String image;
  late String name;
  late String description;

  SearchSubData.fromJson(Map<String, dynamic> jsonData)
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
