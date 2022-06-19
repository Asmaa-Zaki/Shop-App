import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/Block/Cubit.dart';
import 'package:shop_app/Modules/Block/States.dart';
import '../Models/favouritesModel.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavouritesModel? cubit = ShopCubit.get(context).favouritesModel;
    bool favColor = true;
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) => ConditionalBuilder(
            condition: state is !ShopLoadingFavScreen,
            builder: (context) => Container(
                child: ListView.separated(
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
                                      cubit!.data.data[index].product.image),
                                  height: 100,
                                  width: 150,
                                ),
                                if (cubit.data.data[index].product.discount >
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
                                  cubit.data.data[index].product.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      cubit.data.data[index].product.price
                                          .toString(),
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    if (cubit
                                            .data.data[index].product.discount >
                                        0)
                                      Text(
                                        cubit.data.data[index].product.oldPrice
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
                                            cubit.data.data[index].product.id);
                                      },
                                      icon: Icon(
                                          ShopCubit.get(context).favouritesProd[
                                                  cubit.data.data[index].product
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
                    itemCount: cubit!.data.data.length)),
            fallback: (context) => Center(child: CircularProgressIndicator())),
        listener: (context, state){});
  }
}
