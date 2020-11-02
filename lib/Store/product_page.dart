import 'package:eMart/Config/firebase_services.dart';
import 'package:eMart/Config/size_config.dart';
import 'package:eMart/Widgets/customAppBar.dart';
import 'package:eMart/Widgets/default_button.dart';
import 'package:eMart/Widgets/image_swap.dart';
import 'package:eMart/constrants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Tabs/Product/product_color.dart';
import 'Tabs/Product/product_size.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  const ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _selectProductSize = "0";
  String _selectProductColor = "0";

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({
      "size": _selectProductSize,
      "color": _selectProductColor,
    });
  }

  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({
      "size": _selectProductSize,
      "color": _selectProductColor,
    });
  }

  final SnackBar _snackBarCart = SnackBar(
    content: Text("Product added to the Cart"),
  );

  final SnackBar _snackBarSave = SnackBar(
    content: Text("Product Saved"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error : ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //firebase document data map
                Map<String, dynamic> documentData = snapshot.data.data();

                //list of images
                List imageList = documentData['images'];
                //list of sizes
                List productSizes = documentData['size'];
                //list of colors
                List productColors = documentData['color'];

                _selectProductSize = productSizes[0];
                _selectProductColor = productColors[0];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwap(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        "${documentData['name']}",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(25),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "\$${documentData['price']}",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(25),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "${documentData['description']}",
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: getProportionateScreenWidth(18),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 24.0,
                        right: 24.0,
                        bottom: 10.0,
                      ),
                      child: Text(
                        "Color",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ProductColor(
                      productColors: productColors,
                      onSelected: (color) {
                        _selectProductColor = color;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "Size",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ProductSize(
                      productSizes: productSizes,
                      onSelected: (size) {
                        _selectProductSize = size;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _addToSaved();
                              Scaffold.of(context).showSnackBar(_snackBarSave);
                            },
                            child: Container(
                              width: 55.0,
                              height: 55.0,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(17.0),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/icons/bookmark-white.svg",
                                height: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 10.0,
                                ),
                                child: DefaultButton(
                                  color: Colors.red,
                                  text: "Add To Cart",
                                  press: () async {
                                    await _addToCart();
                                    Scaffold.of(context)
                                        .showSnackBar(_snackBarCart);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "",
            hasBackground: false,
          ),
        ],
      ),
    );
  }
}

// const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
// const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
