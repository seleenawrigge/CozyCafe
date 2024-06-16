import 'dart:convert';

import 'package:coffee_shop_project/base/no_data_page.dart';
import 'package:coffee_shop_project/controllers/cart_controller.dart';
import 'package:coffee_shop_project/routes/route_helper.dart';
import 'package:coffee_shop_project/utils/app_contants.dart';
import 'package:coffee_shop_project/utils/colors.dart';
import 'package:coffee_shop_project/widgets/app_icon.dart';
import 'package:coffee_shop_project/widgets/big_text.dart';
import 'package:coffee_shop_project/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/cart_model.dart';
import '../../utils/dimensions.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }
    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var ListCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                AppIcon(

                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,

                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (CartController){
            return CartController.getCartHistoryList().length>0? Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for (int i = 0; i < itemsPerOrder.length; i++)
                          Container(
                            height: Dimensions.height30*4,
                            margin: EdgeInsets.only(bottom: Dimensions.height15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (() {
                                  DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[ListCounter].time!);
                                  var inputDate= DateTime.parse(parseDate.toString());
                                  var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                                  var outputDate = outputFormat.format(inputDate);
                                  return BigText(text: outputDate);

                                  return Text (getCartHistoryList[ListCounter].time!);
                                }()),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children:
                                      List.generate(itemsPerOrder[i], (index) {
                                        if (ListCounter < getCartHistoryList.length) {
                                          ListCounter++;
                                        }
                                        return index <= 2
                                            ? Container(
                                          height: Dimensions.height15*4,
                                          width: Dimensions.height20*4,
                                          margin: EdgeInsets.only(right: Dimensions.width10 / 2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    getCartHistoryList[ListCounter-1].img!, // Use the index here
                                              ),
                                            ),
                                          ),
                                        )
                                            : Container();

                                      }),
                                    ),
                                    Container(
                                      height: Dimensions.height20*4,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SmallText(text: "total", color:AppColors.titleColor,),
                                          BigText(text: itemsPerOrder[i].toString()+ " Items",color: AppColors.titleColor,),
                                          GestureDetector(
                                            onTap: (){
                                              var orderTime = cartOrderTimeToList();
                                              Map<int, CartModel> moreOrder={};
                                              for(int j=0; j<getCartHistoryList.length; j++){
                                                if(getCartHistoryList[j].time==orderTime[i]){
                                                  moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                      CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                  );

                                                }
                                              }
                                              // Get.find<CartController>().setItems = moreOrder;
                                              // Get.find<CartController>().addToCartList();
                                              Get.toNamed(RouteHelper.getCartPage());

                                            },
                                            child:
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                border: Border.all(width: 1,color: AppColors.mainColor),
                                              ),
                                              child: SmallText(text: "Add one", color: AppColors.mainColor,),
                                            ),

                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),

                )):const NoDataPage(
              text: "you have not added anything so far",
              imgPath: "assets/image/empty-cart.png",);

          })
        ],
      ),
    );
    }
  }

