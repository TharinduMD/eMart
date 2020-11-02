import 'package:eMart/Authentication/Login/sign_form.dart';
import 'package:eMart/Config/size_config.dart';
import 'package:eMart/Widgets/no_account_text.dart';
import 'package:eMart/constrants.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  "eMart",
                  style: titleStyle,
                ),
                Text(
                  "Welcome Back",
                  style: headingStyle,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  "Sign in with your email and password  \nto discover the eMart World",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
