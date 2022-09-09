import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/themes.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/shop/login/login_screen.dart';
import 'modules/shop/onborading/on_borading.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getBoolean(key: 'isDark');

  bool onboarding = CacheHelper.getData(key: 'onboarding');


  Widget widget;

   token = CacheHelper.getData(key: 'token');
  print("Tokenis : $token");

  if (onboarding != null) {
    widget = OnBoarding();
  }
   else if (token != null) {
      widget = Shoplayout();
    } else {
      widget = LoginScreen();
    }


  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesdata()..getFavoritedata()..getProfiledata()),
      ],
      child: BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: darkTheme,
              darkTheme: lightTheme,
              themeMode: ShopCubit.get(context).isDark
                  ? ThemeMode.light
                  : ThemeMode.dark,
              home: startWidget);
        },
      ),
    );
  }
}
