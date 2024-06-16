import 'package:flutter/material.dart';
import 'package:coffee_shop_project/utils/colors.dart';
import 'package:coffee_shop_project/widgets/big_text.dart';
import 'package:coffee_shop_project/widgets/small_text.dart';
import 'package:coffee_shop_project/widgets/custom_text_field.dart';
import 'package:coffee_shop_project/utils/dimensions.dart';

import '../widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  var signUpImages = [
    "New-Google-Logo.jpg",
    "twitter.png",
    "fblogo.png",

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Sign Up",
          size: 24,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.width20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: Dimensions.height20),
              CustomTextField(
                controller: _nameController,
                hintText: "Name",
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: Dimensions.height20),
              CustomTextField(
                controller: _emailController,
                hintText: "Email",
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: Dimensions.height20),
              CustomTextField(
                controller: _passwordController,
                hintText: "Password",
                icon: Icons.lock,
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              SizedBox(height: Dimensions.height30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle successful signup
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signing up...')),
                    );
                    // You can navigate to another page or do more processing here
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.mainColor,
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height15,
                    horizontal: Dimensions.width30,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                ),
                child: BigText(
                  text: "Sign Up",
                  size: Dimensions.font20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: Dimensions.height20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallText(
                    text: "Already have an account?",
                    color: Colors.black54,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to login page
                    },
                    child: SmallText(
                      text: "Login",
                      color: AppColors.mainColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: Dimensions.height20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Sign up using one of the following methods",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font16,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10),
              Center(
                child: Wrap(
                  spacing: 20.0, // Adjust as needed
                  children: List.generate(3, (index) =>
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: Dimensions.radius30,
                          backgroundImage: AssetImage(
                            "assets/image/" + signUpImages[index],
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

