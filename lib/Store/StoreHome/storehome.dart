import 'package:flutter/material.dart';
import '../../Models/item.dart';
import 'body.dart';

double width;

class StoreHome extends StatefulWidget {
  static String routeName = "/store";
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    new WillPopScope(child: new Scaffold(), onWillPop: _willPopCallBack);
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Body(),
    );
  }

  Future<bool> _willPopCallBack() async {
    Navigator.pushNamedAndRemoveUntil(
        context, "/store", ModalRoute.withName("/"));
    return false;
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell();
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}

void checkItemInCart(String productID, BuildContext context) {}
