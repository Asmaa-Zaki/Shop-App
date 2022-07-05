import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/Block/Cubit.dart';
import 'package:shop_app/Modules/Block/States.dart';
import 'package:shop_app/Shared/Components.dart';
import 'package:shop_app/Shared/constants.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    bool favColor = true;

    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: defaultColor,
            title: const Text("Search"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                defaultTextFormField(
                    label: "Search",
                    controller: searchController,
                    validate: (val) {
                      if (val!.isEmpty) {
                        return "Search is Required";
                      }
                      return null;
                    },
                    prefix: Icons.search,
                    onEditingComplate: () {
                      cubit.getSearch(text: searchController.text);
                    }),
                Expanded(
                  child: ConditionalBuilder(
                      condition: ShopCubit.get(context).searchModel != null,
                      builder: (context) =>
                          buildSearchList(cubit.searchModel!, favColor),
                      fallback: (context) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          )),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
