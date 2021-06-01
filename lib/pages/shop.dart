import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/widgets/custum.dart';

class ShopScrean extends StatefulWidget {
  @override
  _ShopScreanState createState() => _ShopScreanState();
}

class _ShopScreanState extends State<ShopScrean> {
  var idx = 0;
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
            children: [
              buildAppBarForPages(context, 'Shop'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSearch(hint: "Search"),
                    SizedBox(height: response.setHeight(20)),
                    Container(
                      width: response.screenWidth,
                      height: 60,
                      decoration: BoxDecoration(
                          color: kwhite.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ksecondary, width: 1)),
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              5,
                              (index) => Row(
                                    children: [
                                      buldTextForRow("Drinks", index, () {
                                        setState(() {
                                          idx = index;
                                        });
                                      }),
                                      (index == 5 - 1) ||
                                              (idx == index || idx - 1 == index)
                                          ? Container()
                                          : SizedBox(
                                              height: 20,
                                              child: VerticalDivider(
                                                color: ksecondary,
                                                thickness: 1.5,
                                              ),
                                            )
                                    ],
                                  ))),
                    ),
                    SizedBox(
                      height: response.setHeight(15),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: buildText("Drinks"),
                    ),
                    SizedBox(
                      height: response.setHeight(8),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: List.generate(10, (index) => buildShopItem())),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50.0),
                width: double.infinity,
                height: 120, //MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
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
                      child: buildText2('3 item in cart'),
                    ),
                    SizedBox(height: 3),
                    buildIconElevatedButton(
                        icon: Image.asset("assets/images/cart.png"),
                        label: 'Shopping Cart',
                        onpressed: () {})
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
