import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/HomeModel.dart';
import 'package:shop_app/Models/SearchModel.dart';
import 'package:shop_app/Models/favouritesModel.dart';
import 'package:shop_app/Modules/Block/States.dart';
import 'package:shop_app/Shared/Local/CacheHelper.dart';
import 'package:shop_app/Shared/Network/DioHelper.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shared/endpoints.dart';
import '../../Models/CategoriesModel.dart';
import '../../Models/LoginModel.dart';
import '../../Shared/Components.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopLLoginInitialState());
  late ShopUserModel? userData;
  late ShopUserModel? userSignUpData;
  ShopHomeModel? homeData;
  CategoryModel? categoryModel;
  FavouritesModel? favouritesModel;
  SearchModel? searchModel;
  Map<int, bool> favouritesProd = {};
  ShopUserModel? getProfile;
  late String LogoutMessage;

  static ShopCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  void userLogin({@required String? email, @required String? password}) {
    emit(ShopLLoginLoadingState());

    DioHelper.postData(
            url: login,
            data: {"email": email, "password": password},
            lang: "en")
        .then((value) {
      userData = ShopUserModel.fromJson(value.data);
      print(userData?.data?.token);
      token = userData?.data?.token;
      emit(ShopLLoginSuccessState(userData!));
    }).catchError((error) {
      print(error);
      emit(ShopLLoginErrorState(error.toString()));
    });
  }

  void loadHome() {
    emit(ShopHomeLoadScreen());
    DioHelper.getData(url: home, token: token).then((value) {
      homeData = ShopHomeModel.fromJson(value.data);
      homeData?.data.products.forEach((element) {
        favouritesProd.addAll({element.id: element.inFavorites});
      });
      print(homeData?.status);
      emit(ShopHomeSuccessScreen());
    }).catchError((err) {
      print(err);
      emit(ShopHomeFailScreen());
    });
  }

  void loadCategories() {
    DioHelper.getData(url: categories).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print(categoryModel?.status);
      emit(ShopCatSuccessScreen());
    }).catchError((err) {
      print(err);
      emit(ShopCatFailScreen());
    });
  }

  void changeFavourites(int productId) {
    emit(ShopLoadingFavScreen());
    favouritesProd[productId] = !favouritesProd[productId]!;
    print(favouritesProd[productId]);
    print(token);
    emit(ShopChangeFavUIScreen());
    DioHelper.postData(
            url: favorites, data: {"product_id": productId}, token: token)
        .then((value) {
      print(favouritesProd);
      if (!homeData!.status) {
        favouritesProd[productId] = !favouritesProd[productId]!;
      } else {
        getFavourites();
      }
      emit(ShopChangeFavSuccessScreen());
    }).catchError((err) {
      print(err);
      favouritesProd[productId] = !favouritesProd[productId]!;
      emit(ShopChangeFavFailScreen());
    });
  }

  void getFavourites() {
    DioHelper.getData(url: favorites, token: token).then((value) {
     // print(value.data["data"]["data"][0]);
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopGetFavSuccessScreen());
    }).catchError((err) {
      print(err);
      emit(ShopGetFavFailScreen());
    });
  }

  void getSearch({@required String? text}) {
    emit(ShopSearchLoadScreen());
    DioHelper.postData(url: search, data: {"text": text}).then((value) {
     /* print(value.data["data"]["data"][1]["discount"]);
      print("old");*/
     // getFavourites();
      searchModel= SearchModel.fromJson(value.data);
      //print(searchModel?.data.data[0].name);
      emit(ShopSearchSuccessScreen());
    }).catchError((err) {
      print(err);
      emit(ShopSearchFailScreen());
    });
  }

  void getProfileData() {
    emit(ShopLoadingProfileScreen());
    DioHelper.getData(url: profile, token: token).then((value) {
      getProfile = ShopUserModel.fromJson(value.data);
      print(getProfile!.data?.token);
      emit(ShopSuccessProfileScreen());
    }).catchError((err) {
      print(err);
      emit(ShopFailProfileScreen());
    });
  }

  void UpdateUser({String? name, String? phone, String? email}) {
    emit(ShopLoadingUpdateScreen());
    DioHelper.putData(
        url: updateProfile,
        token: token,
        data: {"name": name, "phone": phone, "email": email}).then((value) {
      getProfileData();
      emit(ShopSuccessUpdateScreen());
    }).catchError((onError) {
      emit(ShopFailUpdateScreen());
    });
  }

  void SignUp(
      {@required String? name,
      @required String? phone,
      @required String? email,
      @required String? password}) {
    emit(ShopSignUpLoadingScreen());
    DioHelper.postData(url: register, data: {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password
    }).then((value) {
      userSignUpData = ShopUserModel.fromJson(value.data);
      print(userSignUpData?.status);
      token = userSignUpData?.data?.token;
      emit(ShopSuccessSignUpScreen(userSignUpData!));
    }).catchError((onError) {
      emit(ShopFailSignUpScreen());
      print(onError);
    });
  }

  void LogOut() {
    DioHelper.postData(url: logout, token: token).then((value) {
      LogoutMessage = value.data["message"];
      CacheHelper.removeKey(key: "token");
      buildShopToast(message: LogoutMessage, state: LoginState.success);
      emit(ShopSuccessLogoutScreen());
    }).catchError((onError) {
      emit(ShopFailLogoutScreen());
    });
  }
}
