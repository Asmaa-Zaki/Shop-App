class ShopUserModel {
  late bool status;
  late String? message;
  late UserData? data;

  ShopUserModel.fromJson(Map<String, dynamic> jsonData){
     status= jsonData["status"];
     message= jsonData["message"];
     data= jsonData["data"] != null ? UserData.fromJson(jsonData["data"]): null;
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;

  UserData.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    image = jsonData['image'];
    token = jsonData['token'];
  }
}
