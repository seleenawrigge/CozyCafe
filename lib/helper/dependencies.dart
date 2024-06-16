import 'package:coffee_shop_project/controllers/cart_controller.dart';
import 'package:coffee_shop_project/controllers/popular_product_controller.dart';
import 'package:coffee_shop_project/data/api/api_client.dart';
import 'package:coffee_shop_project/data/repository/popular_product_repo.dart';
import 'package:coffee_shop_project/utils/app_contants.dart';
import 'package:get/get.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<void> init()async {
    final sharedPreferences = await SharedPreferences.getInstance();

    Get.lazyPut(() => sharedPreferences);

  //api client
    Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL));

    //repos
    Get.lazyPut(() => PopularProductRepo(apiClient:Get.find()));
    Get.lazyPut(() => RecommendedProductRepo(apiClient:Get.find()));
    Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));

    //controllers
    Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
    Get.lazyPut(() => RecommendedProductController(recommendedProductRepo:Get.find()));
    Get.lazyPut(() => CartController(cartRepo: Get.find()));


}