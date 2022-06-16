import 'package:flutter/material.dart';
import '../Shared/Components.dart';
import 'Block/Cubit.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => SizedBox(
          height: 120,
          width: 120,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: buildCatItem(context, index),
          ),
        ),
        separatorBuilder: (context, index) => Container(height: 1, color: Colors.grey[300],),
        itemCount: ShopCubit.get(context).categoryModel!.data.data.length);
  }
}
