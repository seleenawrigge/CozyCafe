import 'package:coffee_shop_project/utils/colors.dart';
import 'package:coffee_shop_project/widgets/big_text.dart';
import 'package:coffee_shop_project/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

import 'coffee_page_body.dart';

class MainCoffeePage extends StatefulWidget {
  const MainCoffeePage({super.key});

  @override
  State<MainCoffeePage> createState() => _MainCoffeePageState();
}

class _MainCoffeePageState extends State<MainCoffeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top:Dimensions.height45, bottom:Dimensions.height45),
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(text: "Sri Lanka", color: AppColors.mainColor),
                        Row(
                          children: [
                            SmallText(text: "Colombo", color: Colors.black54,),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )

                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        child: Icon(Icons.search, color:Colors.white, size:Dimensions.iconSize24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ],
                )
            ),

          ),
          Expanded(child: SingleChildScrollView(
          child: CoffeePageBody(),
          ),
          )

        ],
      ),
    );
  }
}
