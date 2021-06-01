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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [kcolor1, Colors.grey[200], kcolor1])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildAppBarForPages(context, 'Cart'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: response.setHeight(5),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: buildText("Order review"),
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
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50.0),
                width: double.infinity,
                height: 142,
                decoration: BoxDecoration(
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
                          GoTo(context, ShopScrean());
                        }),
                    SizedBox(height: 5),
                    buildFillElevatedButton(
                        text: 'Checkout',
                        onpressed: () {
                          GoTo(context, CheckoutScrean());
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
