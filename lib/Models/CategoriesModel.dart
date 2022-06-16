class CategoryModel
{
  late bool status;
  String? message;
  late CategoryData data;

  CategoryModel.fromJson(Map<String, dynamic> jsonData)
  {
    status = jsonData["status"];
    message = jsonData["message"];
    data = CategoryData.formJson(jsonData["data"]);
  }
}

class CategoryData{
  late int currentPage;
  List<CategorySubData> data= [];
  CategoryData.formJson(Map<String, dynamic> jsonData)
  {
    currentPage = jsonData["current_page"];
    jsonData["data"].forEach((element)=>
      data.add(CategorySubData.fromJson(element))
    );
  }
}

class CategorySubData
{
  late int id;
  late String name;
  late String image;

  CategorySubData.fromJson(Map<String, dynamic> jsonData)
  {
    id = jsonData["id"];
    name = jsonData["name"];
    image = jsonData["image"];
  }
}

