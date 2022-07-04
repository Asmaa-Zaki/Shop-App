import 'package:shop_app/Models/LoginModel.dart';

abstract class ShopStates{}

class ShopLLoginInitialState extends ShopStates{}

class ShopLLoginLoadingState extends ShopStates{}

class ShopLLoginSuccessState extends ShopStates{
  final ShopUserModel userData;
  ShopLLoginSuccessState(this.userData);
}

class ShopLLoginErrorState extends ShopStates{
  final String error;
  ShopLLoginErrorState(this.error);
}

class ShopHomeLoadScreen extends ShopStates{}

class ShopHomeSuccessScreen extends ShopStates{}

class ShopHomeFailScreen extends ShopStates{}

class ShopSearchLoadScreen extends ShopStates{}

class ShopSearchSuccessScreen extends ShopStates{}

class ShopSearchFailScreen extends ShopStates{}

class ShopCatSuccessScreen extends ShopStates{}

class ShopCatFailScreen extends ShopStates{}

class ShopChangeFavUIScreen extends ShopStates{}

class ShopChangeFavSuccessScreen extends ShopStates{}

class ShopChangeFavFailScreen extends ShopStates{}

class ShopLoadingFavScreen extends ShopStates{}

class ShopGetFavSuccessScreen extends ShopStates{}

class ShopGetFavFailScreen extends ShopStates{}

class ShopLoadingProfileScreen extends ShopStates{}

class ShopSuccessProfileScreen extends ShopStates{}

class ShopFailProfileScreen extends ShopStates{}

class ShopSuccessLogoutScreen extends ShopStates{}

class ShopFailLogoutScreen extends ShopStates{}

class ShopLoadingUpdateScreen extends ShopStates{}

class ShopSuccessUpdateScreen extends ShopStates{}

class ShopFailUpdateScreen extends ShopStates{}

class ShopSignUpLoadingScreen extends ShopStates{}

class ShopSuccessSignUpScreen extends ShopStates{
  final ShopUserModel userSignData;
  ShopSuccessSignUpScreen(this.userSignData);
}

class ShopFailSignUpScreen extends ShopStates{}