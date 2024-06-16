
import 'package:coffee_shop_project/auth/log_in_page.dart';
import 'package:coffee_shop_project/controllers/popular_product_controller.dart';
import 'package:coffee_shop_project/pages/cart/cart_page.dart';
import 'package:coffee_shop_project/pages/food/popular_food_detail.dart';
import 'package:coffee_shop_project/pages/food/recommended_food_deails.dart';
import 'package:coffee_shop_project/pages/home/coffee_page_body.dart';
import 'package:coffee_shop_project/pages/home/home_page.dart';
import 'package:coffee_shop_project/pages/home/main_coffee_page.dart';
import 'package:coffee_shop_project/pages/splash/splash_page.dart';
import 'package:coffee_shop_project/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/sign_up_page.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: LoginPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );

      });
    });
  }
}


