import 'package:eMart/Authentication/Register/complete_profile/body.dart';
import 'package:eMart/Authentication/Register/register.dart';
import 'package:eMart/Authentication/Register/sign_up_form.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(),
    );
  }
}
