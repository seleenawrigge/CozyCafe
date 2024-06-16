import 'package:flutter/material.dart';
import 'package:coffee_shop_project/widgets/big_text.dart';
import 'package:coffee_shop_project/widgets/small_text.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            // Profile Icon
            Container(
              width: Dimensions.height15 * 10,
              height: Dimensions.height15 * 10,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: Dimensions.height15 * 7,
                color: Colors.white,
              ),
            ),
            SizedBox(height: Dimensions.height20),
            // User Information
            BigText(
              text: "John Doe",
              size: Dimensions.font26,
              color: Colors.black,
            ),
            SizedBox(height: Dimensions.height10),
            SmallText(
              text: "johndoe@example.com",
              color: Colors.black54,
            ),
            SizedBox(height: Dimensions.height30),
            // Profile Options
            Expanded(
              child: ListView(
                children: [
                  ProfileMenuItem(
                    icon: Icons.edit,
                    text: "Edit Profile",
                    onTap: () {
                      // Handle edit profile tap
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.security,
                    text: "Change Password",
                    onTap: () {
                      // Handle change password tap
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.notifications,
                    text: "Notifications",
                    onTap: () {
                      // Handle notifications tap
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.logout,
                    text: "Logout",
                    onTap: () {
                      // Handle logout tap
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.width20,
          vertical: Dimensions.height10,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width20,
          vertical: Dimensions.height15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.mainColor,
              size: Dimensions.iconSize24,
            ),
            SizedBox(width: Dimensions.width20),
            BigText(
              text: text,
              size: Dimensions.font20,
              color: Colors.black,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: Dimensions.iconSize24,
            ),
          ],
        ),
      ),
    );
  }
}
