import 'package:eMart/Authentication/Register/register.dart';
import 'package:eMart/Splash%20Screen/splash_screen.dart';
import 'package:flutter/material.dart';

import 'Authentication/Login/login.dart';
import 'Authentication/Register/complete_profile/complete_profile.dart';
import 'Store/StoreHome/storehome.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  Login.routeName: (context) => Login(),
  Register.routeName: (context) => Register(),
  //CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  StoreHome.routeName: (context) => StoreHome(),
};
