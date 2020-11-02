import 'package:eMart/Authentication/Login/login.dart';
import 'package:eMart/Config/config.dart';
import 'package:eMart/Config/size_config.dart';
import 'package:eMart/Splash%20Screen/splash_content.dart';
import 'package:eMart/Splash%20Screen/splash_screen.dart';
import 'package:eMart/Store/StoreHome/storehome.dart';
import 'package:eMart/Widgets/default_button.dart';
import 'package:flutter/material.dart';
import '../constrants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  void initState() {
    super.initState();

    SplashScreen();
  }

  userDisplay() {
    if (EcommerceApp.auth.currentUser != null) {
      Navigator.pushNamed(context, StoreHome.routeName);
    } else {
      Navigator.pushNamed(context, Login.routeName);
    }
  }

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to eMart, Let's shop!",
      "image": "assets/images/market.png"
    },
    {
      "text": "Anything you WANT, All in ONE place \nJust stay at home with Us",
      "image": "assets/images/caucasian.jpg"
    },
    {
      "text":
          "Easy Safe & Guarantee to your Personality\nBe our Happy customer",
      "image": "assets/images/family.jpg"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]["text"],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          splashData.length, (index) => buildDot(index: index)),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        userDisplay();
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(80)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
