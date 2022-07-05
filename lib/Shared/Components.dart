import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Models/SearchModel.dart';
import '../Models/HomeModel.dart';
import '../Modules/Block/Cubit.dart';
import '../Modules/LoginScreen.dart';
import 'Local/CacheHelper.dart';

Widget buildOnBoard(String image, String text, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10),
        child: Image.asset(image, height: 350),
      ),
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5),
        child: Text(text, style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Theme.of(context).primaryColor
        ),
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}

Widget defaultTextFormField(
    {
      @required String? label,
      @required TextEditingController? controller,
      @required String? Function(String?)? validate,
      IconData? prefix,
      IconData? suffix,
      TextInputType? keyboard,
      bool password= false,
      Function()? changePassword,
      Function()? onEditingComplate,
    }) {
  return TextFormField(
    keyboardType: keyboard,
    controller: controller,
    validator: validate,
    obscureText: password,
    onEditingComplete: onEditingComplate,
    decoration: InputDecoration(
        fillColor: Colors.grey[200],
        isDense: true,
        label: Text(label!),
        prefixIcon: Icon(prefix),
        suffixIcon: GestureDetector(child: Icon(suffix), onTap: changePassword,),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red
          )
      ),
    ),
  );
}


Widget labelField(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}

Future<bool?> buildShopToast({@required String? message, Toast? toastLength, @required LoginState? state}) {
  return Fluttertoast.showToast(
      msg: message!,
      toastLength: toastLength,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor(state!),
      textColor: state == LoginState.warning? Colors.black : Colors.white,
      fontSize: 16.0
  );
}

enum LoginState{
  success, fail, warning
}

Color toastColor(LoginState state)
{
  if(state == LoginState.success) return Colors.green;
  if(state == LoginState.fail) return Colors.red;
  return Colors.yellow;
}


Future<dynamic> navigateTo(BuildContext context, Widget screen)
{
  return Navigator.push(context, MaterialPageRoute(builder: (context)=> screen));
}

Future<dynamic> navigateAndReplace(BuildContext context, Widget screen)
{
  return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> screen));
}

Widget buildGridView(ShopHomeModel? homeModel, context) {
  return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      childAspectRatio: 1 / 1.4,
      children: List.generate(
        homeModel!.data.products.length,
            (index) =>   Container(
            color: Colors.white,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment:
                  AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(homeModel
                          .data.products[index].image),
                      height: 150,
                      width: double.infinity,
                    ),
                    if(homeModel.data.products[index].discount>0)
                      Container(
                        padding: EdgeInsets.all(1),
                        child: const Text(
                          "Discount",
                          style:
                          TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10,10,10,0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          homeModel
                              .data.products[index].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              height: 1.3, fontSize: 13),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Row(children: [
                          Text(
                            homeModel
                                .data.products[index].price
                                .round()
                                .toString(),
                            style: const TextStyle(
                                color: Colors.blue),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          if (homeModel.data.products[index]
                              .discount !=
                              0)
                            Text(
                              homeModel.data.products[index]
                                  .oldPrice
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration
                                      .lineThrough),
                            ),
                          const Spacer(),
                          IconButton(
                              iconSize: 22,
                              onPressed: () {
                                ShopCubit.get(context).changeFavourites(homeModel.data.products[index].id);
                              },
                              icon: Icon( !ShopCubit.get(context).favouritesProd[homeModel.data
                                  .products[index].id]!?
                                  Icons.favorite_outline: Icons.favorite, color: Colors.red,)
                          )

                        ]),
                      ],
                    ))
              ],
            )),
      ));
}

Widget buildBanner(ShopHomeModel? homeModel) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: CarouselSlider(
      items: homeModel?.data.banners.map((e) {
        return Image(
          image: NetworkImage(e.image),
          fit: BoxFit.cover,
        );
      }).toList(),
      options: CarouselOptions(
          height: 200, autoPlay: true, viewportFraction: 1),
    ),
  );
}

Widget buildCategories(BuildContext context) {
  return SizedBox(
    height: 100,
    child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index)=> Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Image(image: NetworkImage(ShopCubit.get(context).categoryModel!.data.data[index].image),
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
              Container(
                width: 120,
                color: Colors.black.withOpacity(.8),
                child: Text(ShopCubit.get(context).categoryModel!.data.data[index].name, style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )
                ,
              )
            ],
          ),
          separatorBuilder: (context, index)=> SizedBox(width: 5),
          itemCount: ShopCubit.get(context).categoryModel!.data.data.length),
  );
}

Widget buildCatItem(BuildContext context, int index) {
  return Row(
    children: [Image(image: NetworkImage(ShopCubit.get(context).categoryModel!.data.data[index].image),
      fit: BoxFit.cover,
      height: 120,
      width: 120,),
      const SizedBox(width: 10,),
      Text(ShopCubit.get(context).categoryModel!.data.data[index].name, style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17
      ),),
      const Spacer(),
      IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios))
    ],
  );
}

ListView buildProductList(var model, bool favColor) {
  return ListView.separated(
      itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(6.0),
          color: Colors.white,
          height: 100,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                        model!.data.data[index].product.image),
                    height: 100,
                    width: 150,
                  ),
                  if (model.data.data[index].product.discount >
                      0)
                    Container(
                      padding: EdgeInsets.all(2),
                      child: const Text(
                        "Discount",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red.withOpacity(.8),
                    )
                ],
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.data.data[index].product.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            model.data.data[index].product.price
                                .toString(),
                            style: TextStyle(color: Colors.blue),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (model
                              .data.data[index].product.discount >
                              0)
                            Text(
                              model.data.data[index].product.oldPrice
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration:
                                  TextDecoration.lineThrough),
                            ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              favColor = !favColor;
                              ShopCubit.get(context).changeFavourites(
                                  model.data.data[index].product.id);
                            },
                            icon: Icon(
                                ShopCubit.get(context).favouritesProd[
                                model.data.data[index].product
                                    .id]!
                                    ? Icons.favorite
                                    : Icons.favorite_outline),
                            color: Colors.red,
                          ),
                        ],
                      )
                    ],
                  )),
              Container(
                alignment: AlignmentDirectional.bottomEnd,
              )
            ],
          )),
      separatorBuilder: (context, index) => Container(
        height: 2,
        color: Colors.grey[200],
      ),
      itemCount: model!.data.data.length);
}

ListView buildSearchList(SearchModel model, bool favColor) {
  return ListView.separated(
      itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(6.0),
          color: Colors.white,
          height: 100,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                        model!.data.data[index].image),
                    height: 100,
                    width: 120,
                  ),
                  if (model.data.data[index].discount != null)
                    Container(
                      padding: EdgeInsets.all(2),
                      child: const Text(
                        "Discount",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red.withOpacity(.8),
                    )
                ],
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.data.data[index].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            model.data.data[index].price
                                .toString(),
                            style: TextStyle(color: Colors.blue),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (model.data.data[index].discount != null    &&  model.data.data[index].discount!> 0)
                            Text(
                              model.data.data[index].oldPrice
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration:
                                  TextDecoration.lineThrough),
                            ),
                          Spacer(),
                          /*IconButton(
                            onPressed: () {
                              favColor = !favColor;
                              ShopCubit.get(context).changeFavourites(
                                  model.data.data[index].id);
                            },
                            icon: Icon(
                                ShopCubit.get(context).favouritesProd[
                                model.data.data[index]
                                    .id]!
                                    ? Icons.favorite
                                    : Icons.favorite_outline),
                            color: Colors.red,
                          ),*/
                        ],
                      )
                    ],
                  )),
              Container(
                alignment: AlignmentDirectional.bottomEnd,
              )
            ],
          )),
      separatorBuilder: (context, index) => Container(
        height: 2,
        color: Colors.grey[200],
      ),
      itemCount: model.data.data.length);
}

void navigateToLogin(BuildContext context)
{
  CacheHelper.setData(key: "onBoardingOpened", value: true).then((value) =>
      navigateAndReplace(context, LoginScreen())
  );
}
