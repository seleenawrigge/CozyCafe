import 'package:coffee_shop_project/pages/cart/cart_page.dart';
import 'package:coffee_shop_project/pages/food/popular_food_detail.dart';
import 'package:coffee_shop_project/pages/home/home_page.dart';
import 'package:coffee_shop_project/pages/home/main_coffee_page.dart';
import 'package:coffee_shop_project/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import '../pages/food/recommended_food_deails.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, [String? page]) =>
      '$popularFood?pageId=$pageId${page != null ? '&page=$page' : ''}';
  static String getRecommendedFood(int pageId, [String? page]) =>
      '$recommendedFood?pageId=$pageId${page != null ? '&page=$page' : ''}';
  static String getCartPage() => cartPage;

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(
      name: initial,
      page: () => HomePage(),
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return PopularFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
      transition: Transition.fadeIn,
    )

  ];
}
