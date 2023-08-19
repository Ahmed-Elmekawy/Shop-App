import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/shop_bloc/cubit.dart';
import 'package:shopping/consts/consts.dart';
import 'package:shopping/modules/onboarding_screen.dart';
import 'package:shopping/bloc/bloc_observer.dart';
import 'package:shopping/modules/shop_layout/shop_layout.dart';
import 'package:shopping/network/local/cashe_helper.dart';
import 'package:shopping/network/remote/dio_helper.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  token=CacheHelper.getData(key: "token");
  runApp(MyApp(token));
}

class MyApp extends StatelessWidget {
  final dynamic token;
  const MyApp(this.token, {super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token==null? const OnBoarding():const ShopLayout(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            actionsIconTheme: IconThemeData(color: Colors.black),
            elevation: 0.0
        )
      ),
    );
  }
}