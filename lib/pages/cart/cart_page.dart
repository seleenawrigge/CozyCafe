import 'package:coffee_shop_project/base/no_data_page.dart';
import 'package:coffee_shop_project/controllers/cart_controller.dart';
import 'package:coffee_shop_project/pages/home/main_coffee_page.dart';
import 'package:coffee_shop_project/utils/colors.dart';
import 'package:coffee_shop_project/utils/dimensions.dart';
import 'package:coffee_shop_project/widgets/app_icon.dart';
import 'package:coffee_shop_project/widgets/big_text.dart';
import 'package:coffee_shop_project/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';


import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_contants.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: Dimensions.width20,
            top: Dimensions.height20 * 3,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios_new,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  size: Dimensions.iconSize24, // Use `size` for container size
                  iconSize:
                      Dimensions.iconSize16, // Use `iconSize` for icon size
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    size: Dimensions.iconSize24,
                    iconSize: Dimensions.iconSize16,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  size: Dimensions.iconSize24,
                  iconSize: Dimensions.iconSize16,
                ),
              ],
            ),
          ),
          //body
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
              top: Dimensions.height20 * 5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0, // Added to give a bottom boundary to the list
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                //color: Colors.red,
                child: Column(
                  children: [
                    // Example of wrapping ListView with a flexible container
                    Expanded(
                      child: MediaQuery.removePadding(
                        context:context,
                        removeTop: true,
                        child: GetBuilder<CartController>(builder: (cartController){
                          var cartList = cartController.getItems;
                          return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                width: double.maxFinite,
                                height: Dimensions.height20*5,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex = Get.find<PopularProductController>()
                                            .popularProductList
                                            .indexOf(cartList[index].product!);

                                        if (popularIndex >= 0) {
                                          Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartpage"));
                                        } else {
                                          var recommendedIndex = Get.find<RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(cartList[index].product!);

                                          if (recommendedIndex >= 0) {
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartpage"));
                                          } else {
                                            Get.snackbar(
                                              "History product",
                                              "Product review is not available for history products.",
                                              backgroundColor: AppColors.mainColor,
                                              colorText: Colors.white,
                                            );
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.height20*5,
                                        height: Dimensions.height20*5,
                                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                                )
                                            ),
                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10,),
                                    Expanded(child: Container(
                                      height: Dimensions.height20*5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                          SmallText(text: "sweet"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: cartController.getItems[index].price.toString(), color: Colors.redAccent,),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,

                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addItems(cartList[index].product!, -1);

                                                        },
                                                        child:
                                                        Icon(Icons.remove, color: AppColors.signColor)),
                                                    SizedBox(
                                                      width: Dimensions.width10 / 2,
                                                    ),
                                                    Container(
                                                      child: BigText(
                                                        text: cartList[index].quantity.toString(), //popularProduct.inCartItems.toString(),
                                                        size: Dimensions.font20,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Dimensions.width10 / 2,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addItems(cartList[index].product!, 1);
                                                        },
                                                        child: Icon(Icons.add, color: AppColors.signColor)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ):NoDataPage(text: "Your cart is empty");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: 120,
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.height20,
              horizontal: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: cartController.getItems.length>0?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [

                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    Container(
                      child: BigText(
                        text:"\$ " +cartController.totalAmount.toString(),
                        size: Dimensions.font20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),

                  ],
                ),
              ),
              Row(
                children: [

                  SizedBox(width: Dimensions.width10),
                  ElevatedButton(
                    onPressed: () {

                      //  popularProduct.addItem(product);
                      cartController.addToHistory();
                      print("tapped");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        SizedBox(width: Dimensions.width20),
                        Text("Check out"),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          )


              : Container(),
          );


        },
      ),
    );
  }
}
