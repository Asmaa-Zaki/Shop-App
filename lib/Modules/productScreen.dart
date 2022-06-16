import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/HomeModel.dart';
import 'package:shop_app/Modules/Block/Cubit.dart';
import 'package:shop_app/Modules/Block/States.dart';
import '../Shared/Components.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, states) {
          ShopHomeModel? homeModel = ShopCubit.get(context).homeData;
          return ConditionalBuilder(
            condition: homeModel != null,
            builder: (context) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildBanner(homeModel),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 23,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        buildCategories(context),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Products",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 23,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  buildGridView(homeModel, context)
                ],
              ),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        listener: (context, states) {});
  }
}
