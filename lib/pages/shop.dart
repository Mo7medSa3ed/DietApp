import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/models/categories.dart';
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
  List<CategoriesModel> data = [];

  var status = false;

  getData() async {
    data.clear();
    final res = await API.getAllCategories();
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    if (res != null) {
      status = res['success'];
      if (res['data'].length > 0) {
        print(res['data']);
        data = res['data']
            .map<CategoriesModel>((e) => CategoriesModel.fromJson(e))
            .toList();
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
            bottomSheet: Container(
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
                mainAxisSize: MainAxisSize.min,
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
            ),
            body: Container(
                decoration: BoxDecoration(
                    gradient: RadialGradient(radius: 1, colors: [
                  kwhite,
                  kcolor1,
                ])),
                child: Column(children: [
                  buildAppBarForPages(
                    context,
                    'Shop',
                    () => scaffoldkey.currentState.openDrawer(),
                  ),
                  !status
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(color: kprimary),
                          ),
                        )
                      : data.length == 0
                          ? Expanded(
                              child: Center(
                                child: buildText("No Data Found ...."),
                              ),
                            )
                          : Expanded(
                              child: ListView(
                                padding: EdgeInsets.all(16),
                                physics: BouncingScrollPhysics(),
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: ksecondary.withOpacity(0.3),
                                            offset: Offset(0, 0),
                                            blurRadius: 15,
                                            spreadRadius: 5)
                                      ],
                                    ),
                                    child: buildSearch(hint: "Search"),
                                  ),
                                  SizedBox(height: response.setHeight(20)),
                                  Container(
                                    width: response.screenWidth,
                                    height: 56,
                                    decoration: BoxDecoration(
                                        color: kwhite.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: ksecondary, width: 1)),
                                    child: ListView(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        children:
                                            List.generate(data.length, (index) {
                                          return Row(
                                            children: [
                                              buldTextForRow(
                                                  data[index].name, index, () {
                                                setState(() {
                                                  idx = index;
                                                });
                                              }),
                                              (index == data.length - 1) ||
                                                      (idx == index ||
                                                          idx - 1 == index)
                                                  ? Container()
                                                  : SizedBox(
                                                      height: 20,
                                                      child: VerticalDivider(
                                                        color: ksecondary,
                                                        thickness: 1.5,
                                                      ),
                                                    )
                                            ],
                                          );
                                        })),
                                  ),
                                  SizedBox(height: response.setHeight(20)),
                                  buildText(data[idx].name),
                                  SizedBox(height: response.setHeight(20)),
                                  data[idx].products.length == 0
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 200),
                                          child: Center(
                                            child: buildText(
                                                "No Products Found ...."),
                                          ),
                                        )
                                      : Column(
                                          children: List.generate(
                                              data[idx].products.length,
                                              (index) => buildShopItem(
                                                    context: context,
                                                    product: data[idx]
                                                        .products[index],
                                                  )))
                                ],
                              ),
                            )
                ]))));
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
