import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/models/product.dart';
import 'package:flutter_test_app/pages/cart.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:provider/provider.dart';

class ShopScrean extends StatefulWidget {
  @override
  _ShopScreanState createState() => _ShopScreanState();
}

class _ShopScreanState extends State<ShopScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  var idx = 0;
  var products = [];

  var status = false;

  getData() async {
    products.clear();
    final res = await API.getAllProducts();
    if (res == 'error')
      return Alert.errorAlert(
          ctx: context,
          title:
              errorMsg);
    if (res != null) {
      status = res['success'];
      if (res['data'].length > 0) {
        products = res['data'].map((e) => ProductModel.fromJson(e)).toList();
      }
    }
    final response = await API.getCart();

    if (response != null) {
      Provider.of<AppProvider>(context, listen: false).changeCartCount(
          int.parse(response['data']['items_count'].toString()));
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
            children: [
              buildAppBarForPages(
                context,
                'Shop',
                () => scaffoldkey.currentState.openDrawer(),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //           boxShadow: [
              //             BoxShadow(
              //                 color: ksecondary.withOpacity(0.3),
              //                 offset: Offset(0, 0),
              //                 blurRadius: 15,
              //                 spreadRadius: 5)
              //           ],
              //         ),
              //         child: buildSearch(hint: "Search"),
              //       ),
              //       SizedBox(height: response.setHeight(20)),
              //       Container(
              //         width: response.screenWidth,
              //         height: 56,
              //         decoration: BoxDecoration(
              //             color: kwhite.withOpacity(0.9),
              //             borderRadius: BorderRadius.circular(20),
              //             border: Border.all(color: ksecondary, width: 1)),
              //         child: ListView(
              //    physics: BouncingScrollPhysics(),
              //             scrollDirection: Axis.horizontal,
              //             children: List.generate(
              //                 5,
              //                 (index) => Row(
              //                       children: [
              //                         buldTextForRow("Drinks", index, () {
              //                           setState(() {
              //                             idx = index;
              //                           });
              //                         }),
              //                         (index == 5 - 1) ||
              //                                 (idx == index || idx - 1 == index)
              //                             ? Container()
              //                             : SizedBox(
              //                                 height: 20,
              //                                 child: VerticalDivider(
              //                                   color: ksecondary,
              //                                   thickness: 1.5,
              //                                 ),
              //                               )
              //                       ],
              //                     ))),
              //       ),
              //       SizedBox(
              //         height: response.setHeight(15),
              //       ),
              //       Container(
              //         padding: EdgeInsets.symmetric(horizontal: 8),
              //         child: buildText("Drinks"),
              //       ),
              //       SizedBox(
              //         height: response.setHeight(8),
              //       ),
              //     ],
              //   ),
              // ),
              !status
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: kprimary),
                      ),
                    )
                  : products.length == 0
                      ? Expanded(
                          child: Center(
                            child: buildText("No Data Found ...."),
                          ),
                        )
                      : Expanded(
                          child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: List.generate(
                                  products.length,
                                  (index) => buildShopItem(
                                        context: context,
                                        product: products[index],
                                      ))),
                        ),

              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24.0),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Selector<AppProvider, int>(
                          selector: (context, app) => app.cartCount,
                          builder: (context, i, w) =>
                              buildText2('$i item in cart')),
                    ),
                    SizedBox(height: 3),
                    buildIconElevatedButton(
                        icon: Image.asset("assets/images/cart.png"),
                        label: 'Shopping Cart',
                        onpressed: () =>
                            goTo(context, CartScrean(), then: (v) async {
                              final response = await API.getCart();
                              if (response != null) {
                                Provider.of<AppProvider>(context, listen: false)
                                    .changeCartCount(int.parse(response['data']
                                            ['items_count']
                                        .toString()));
                              }
                            }))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buldTextForRow(text, indx, ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        decoration: BoxDecoration(
          color: idx == indx
              ? ksecondary.withOpacity(0.8)
              : kwhite.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: idx == indx ? kprimary : ksecondary,
            ),
          ),
        ),
      ),
    );
  }
}
