import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Layout/shopLayout.dart';
import 'package:shop_app/Modules/Block/Cubit.dart';
import 'package:shop_app/Modules/SignupScreen.dart';
import 'package:shop_app/Shared/Local/CacheHelper.dart';
import 'package:shop_app/Shared/constants.dart';
import '../Shared/Components.dart';
import 'Block/States.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formState = GlobalKey<FormState>();
  bool passwordVisible= true;
  IconData suffixIcon= Icons.remove_red_eye;
  late String message;

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit, ShopStates>(
          listener: (BuildContext context, Object? state) {
            if( state is ShopLLoginSuccessState)
              {
                message = state.userData.message!;
                if(state.userData.status)
                  {
                    buildShopToast(message: message, state: LoginState.success, toastLength: Toast.LENGTH_SHORT);
                    CacheHelper.setData(key: "token", value: state.userData.data?.token).then((value) {
                      navigateAndReplace(context, ShopLayout());
                      token= state.userData.data?.token;
                    });
                  }
                else
                  {
                    buildShopToast(message: message, state: LoginState.fail, toastLength: Toast.LENGTH_LONG);
                  }
              }
          },
          builder: (BuildContext context, state) {
            ShopCubit cubit = ShopCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Form(
                  key: formState,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 30),
                        height: MediaQuery.of(context).size.height - 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  "Welcome!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Please enter your data to continue",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                labelField("Username"),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultTextFormField(
                                    controller: emailController,
                                    label: "Email",
                                    validate: (input) {
                                      if (input!.isEmpty) {
                                        return "Email Field is Required";
                                      }
                                      return null;
                                    },
                                    prefix: Icons.email_outlined),
                              ],
                            ),
                            Column(
                              children: [
                                labelField("Password"),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultTextFormField(
                                  password: passwordVisible,
                                  changePassword: (){
                                    setState(() {
                                      passwordVisible= !passwordVisible;
                                    });
                                  },
                                  controller: passwordController,
                                  label: "Password",
                                  validate: (input) {
                                    if (input!.isEmpty) {
                                      return "Password Field is Required";
                                    }
                                    return null;
                                  },
                                  prefix: Icons.lock,
                                  suffix: !passwordVisible? Icons.visibility: Icons.visibility_off,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                state is! ShopLLoginLoadingState
                                    ? MaterialButton(
                                        minWidth:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        onPressed: () {
                                          if (formState.currentState!
                                              .validate()) {
                                            cubit.userLogin(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                          }
                                        },
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : const CircularProgressIndicator(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account?",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          navigateAndReplace(context, SignupScreen());
                                        },
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }
}
