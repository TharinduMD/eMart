import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eMart/Config/size_config.dart';
import 'package:eMart/Store/cart.dart';
import 'package:eMart/constrants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackground;
  const CustomActionBar({this.title, this.hasBackground});

  @override
  Widget build(BuildContext context) {
    bool _hasBackGround = hasBackground ?? true;
    final CollectionReference _userRef =
        FirebaseFirestore.instance.collection("Users");

    User _user = FirebaseAuth.instance.currentUser;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackGround
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                )
              : null),
      padding: EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        bottom: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: TextStyle(
              fontFamily: "ubuntu",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black38,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ));
              },
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: StreamBuilder(
                      stream: _userRef
                          .doc(_user.uid)
                          .collection("Cart")
                          .snapshots(),
                      builder: (context, snapshot) {
                        int _totalItems = 0;

                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          List _documents = snapshot.data.docs;
                          _totalItems = _documents.length;
                        }
                        return Text(
                          "$_totalItems" ?? "0",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5.0,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Cart Icon.svg",
                      color: Theme.of(context).accentColor,
                      height: 37.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
