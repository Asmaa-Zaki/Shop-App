import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/onBoaredingScreen.dart';
import 'package:shop_app/Modules/Block/Cubit.dart';
import 'package:shop_app/Modules/Block/States.dart';
import 'package:shop_app/Modules/LoginScreen.dart';
import 'package:shop_app/Shared/Local/CacheHelper.dart';
import 'package:shop_app/Shared/Network/DioHelper.dart';
import 'Layout/shopLayout.dart';
import 'Shared/BlocObserver.dart';
import 'Shared/constants.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      token = CacheHelper.getData(key: "token");

      var boardingState = CacheHelper.getData(key: "onBoardingOpened");
      Widget widget;

      if (boardingState != null) {
        if (token != null) {
          print(token);
          widget = ShopLayout();
        } else {
          widget = LoginScreen();
        }
      } else {
        widget = OnBoarding();
      }
      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget widget;
  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
      create: (context){return ShopCubit();},
      child: BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, states){
          return MaterialApp(
            theme: ThemeData(
                primaryColor: const Color(0xff3b75a8),
                inputDecorationTheme: const InputDecorationTheme(
                    focusColor: Colors.red,
                    labelStyle: TextStyle(color: Color(0xff3b79a8)),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 10,
                        borderSide: BorderSide(color: Color(0xff3b75a8))))),
            home: widget,
            debugShowCheckedModeBanner: false,
          );
        },
        listener: (context, states){},
      ),
    );
  }
}
