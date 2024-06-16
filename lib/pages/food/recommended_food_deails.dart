import 'package:coffee_shop_project/controllers/popular_product_controller.dart';
import 'package:coffee_shop_project/controllers/recommended_product_controller.dart';
import 'package:coffee_shop_project/pages/cart/cart_page.dart';
import 'package:coffee_shop_project/routes/route_helper.dart';
import 'package:coffee_shop_project/utils/app_contants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../../widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
   const RecommendedFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                  // Consider removing Get.toNamed(RouteHelper.getInitial());
                  // to prevent unnecessary navigation stack reset
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Adjust padding as needed
                  child: AppIcon(icon: Icons.arrow_back_ios_new),
                ),
              ),
              actions: [
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        // Handle cart icon tap here if needed
                      },
                      child: GestureDetector(
                          onTap: (){
                            if(controller.totalItems>=1)
                              Get.toNamed(RouteHelper.getCartPage());
                          },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            if (controller.totalItems >= 1)
                              Positioned(
                                right: 0,
                                top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                              ),
                              Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: controller.totalItems.toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],

                        ),
                      )

                    );
                  },
                ),
              ],
            ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.height20),
                  ExpandableTextWidget(text: product.description!),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder:(controller){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Quantity and price row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: AppColors.signColor),
                        onPressed: () {
                          controller.setQuantity(false);
                        },
                      ),
                      SizedBox(width: Dimensions.width10),

                      SizedBox(width: Dimensions.width10),
                      IconButton(
                        icon: Icon(Icons.add, color: AppColors.signColor),
                        onPressed: () {
                          controller.setQuantity(true);
                        },
                      ),
                    ],
                  ),
                  Text(
                    "\$ ${product.price!} x ${controller.inCartItems} ",
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10), // Add some spacing between rows
              // Add to cart and favorite row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.addItem(product);
                      // Handle add to cart action
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
                        BigText(text: "\$ ${product.price!} | Add to Cart",),
                      ],
                    ),
                  ),
                  IconButton(

                    icon: Icon(Icons.favorite_border, color: AppColors.mainColor),
                    // Favorite button
                    onPressed: () {
                      print("Favorite tapped");
                      // Handle favorite action here
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },)
    );
  }
}
