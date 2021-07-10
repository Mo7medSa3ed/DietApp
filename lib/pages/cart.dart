import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/checout.dart';
import 'package:flutter_test_app/pages/shop.dart';
import 'package:flutter_test_app/widgets/custum.dart';

class CartScrean extends StatefulWidget {
  @override
  _CartScreanState createState() => _CartScreanState();
}

class _CartScreanState extends State<CartScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        drawer: buildDrawer(context),
        body: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [kcolor1, Colors.grey[200], kcolor1])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildAppBarForPages(
                context,
                'Cart',
                () => scaffoldkey.currentState.openDrawer(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: response.setHeight(5),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: buildText(
                        "Order review",
                      ),
                    ),
                    SizedBox(
                      height: response.setHeight(8),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (c, i) => buildCartItem(),
                  itemCount: 5,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ksecondary,
                        offset: Offset(0, -5),
                        blurRadius: 10,
                        spreadRadius: 2)
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: kwhite,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildOutElevatedButton(
                        text: "Continue Shopping",
                        onpressed: () {
                          goTo(context, ShopScrean());
                        }),
                    SizedBox(height: 8),
                    buildFillElevatedButton(
                        text: 'Checkout',
                        onpressed: () {
                          goTo(context, CheckoutScrean());
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
