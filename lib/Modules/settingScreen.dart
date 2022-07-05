import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/Block/Cubit.dart';
import 'package:shop_app/Modules/Block/States.dart';
import 'package:shop_app/Modules/LoginScreen.dart';
import 'package:shop_app/Shared/Components.dart';
import '../Shared/constants.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          nameController.text = ShopCubit.get(context).getProfile!.data!.name;
          emailController.text = ShopCubit.get(context).getProfile!.data!.email;
          phoneController.text = ShopCubit.get(context).getProfile!.data!.phone;

          return ConditionalBuilder(
              condition: state is! ShopLoadingProfileScreen,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Column(
                    children: [
                      if (state is ShopLoadingUpdateScreen)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(
                          label: 'Name',
                          controller: nameController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Name is Required";
                            }
                            return null;
                          },
                          prefix: Icons.person),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                          label: 'Email',
                          controller: emailController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Email is Required";
                            }
                            return null;
                          },
                          prefix: Icons.email),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                          label: 'Phone',
                          controller: phoneController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Phone is Required";
                            }
                            return null;
                          },
                          prefix: Icons.phone),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(defaultColor)),
                          onPressed: () {
                            ShopCubit.get(context).UpdateUser(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          },
                          child: const Text("Update"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(defaultColor)),
                          onPressed: () {
                            ShopCubit.get(context).LogOut();
                            navigateAndReplace(context, LoginScreen());
                          },
                          child: const Text("LogOut"),
                        ),
                      )
                    ],
                  ),
                );
              },
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        },
        listener: (context, state) =>
            {if (state is ShopSuccessLogoutScreen) {}});
  }
}
