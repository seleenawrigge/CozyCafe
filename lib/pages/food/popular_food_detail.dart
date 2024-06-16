import 'package:coffee_shop_project/controllers/cart_controller.dart';
import 'package:coffee_shop_project/controllers/popular_product_controller.dart';
import 'package:coffee_shop_project/pages/home/main_coffee_page.dart';
import 'package:coffee_shop_project/utils/app_contants.dart';
import 'package:coffee_shop_project/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop_project/widgets/app_column.dart';
import 'package:coffee_shop_project/widgets/app_icon.dart';
import 'package:coffee_shop_project/widgets/big_text.dart';
import 'package:coffee_shop_project/utils/colors.dart';
import 'package:coffee_shop_project/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../cart/cart_page.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  final String? page;

  PopularFoodDetail({super.key, required this.pageId, this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
        Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!),
                ),
              ),
            ),
          ),
          //icon widget
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if(page=="cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios_new)


                ),

                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1)
                        Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems>=1?
                        Positioned(
                            right:0, top:0,
                            child: GestureDetector(
                              onTap:(){
                                print("tapped here");
                                Get.toNamed(RouteHelper.getCartPage());
                    },
                                child: AppIcon(icon: Icons.circle, size: 20, iconColor: Colors.transparent, backgroundColor: AppColors.mainColor,))):
                        Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                            right:3, top:3,
                            child: BigText(text:Get.find<PopularProductController>().totalItems.toString(),
                            size: 12, color: Colors.white,
                        ),
                    ):
                        Container()
                      ],
                    ),
                  );
                }

                ),

              ],
            ),
          ),
          //description
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.height20),
                    BigText(text: "Description"),
                    SizedBox(height: Dimensions.height20),
                    ExpandableTextWidget(text: product.description!),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
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
            child: Row(
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
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child:
                          Icon(Icons.remove, color: AppColors.signColor)),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      Container(
                        child: BigText(
                          text: popularProduct.inCartItems.toString(),
                          size: Dimensions.font20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(Icons.add, color: AppColors.signColor)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$ ${product.price!}",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: Dimensions.width10),
                    ElevatedButton(
                      onPressed: () {
                        popularProduct.addItem(product);
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
                          SizedBox(width: Dimensions.width10),
                          Text("Add to Cart"),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
