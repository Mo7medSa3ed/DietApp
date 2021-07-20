import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/models/product.dart';
import 'package:flutter_test_app/pages/checout.dart';
import 'package:flutter_test_app/pages/shop.dart';
import 'package:flutter_test_app/widgets/custum.dart';

class CartScrean extends StatefulWidget {
  @override
  _CartScreanState createState() => _CartScreanState();
}

class _CartScreanState extends State<CartScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  var cartList = [];
  var status = false;

  getData() async {
    final res = await API.getCart();
    
    if (res != null) {
      status = res['success'];
      cartList = res['data']['items']
          .map((e) => ProductModel.fromJsonForCart(e['buyable'], e['quantity'] ,res['data']['id']))
          .toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildAppBarForPages(
                context,
                'Cart',
                () => scaffoldkey.currentState.openDrawer(),
              ),
              !status
                  ? Center(
                      child: CircularProgressIndicator(color: kprimary),
                    )
                  : cartList.length == 0
                      ? Center(
                          child: buildText("No Data Found ...."),
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: response.setHeight(5),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
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
                                  padding: EdgeInsets.only(left: 16, right: 8),
                                  itemBuilder: (c, i) =>
                                      buildCartItem(cartList[i], () async {
                                    final res = await API
                                        .removeProductFromCart(cartList[i].cartId);
                                    if (res != null && res['success']) {
                                      setState(() {
                                        cartList = res['data']['items']
                                            .map((e) =>
                                                ProductModel.fromJsonForCart(
                                                    e['buyable'],
                                                    e['quantity'], res['data']['id'] ))
                                            .toList();
                                      });
                                    }
                                  }),
                                  itemCount: cartList.length,
                                ),
                              ),
                            ],
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
                         bgcolor:cartList.length==0? Colors.grey:kprimary2,
                        onpressed: () {
                          if(cartList.length==0)return;
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
