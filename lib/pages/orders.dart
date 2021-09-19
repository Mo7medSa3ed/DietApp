import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/widgets/custum.dart';

class OrderScrean extends StatefulWidget {
  @override
  _OrderScreanState createState() => _OrderScreanState();
}

class _OrderScreanState extends State<OrderScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  var cartList = [];
  var status = false;

  getData() async {
    cartList.clear();
    final res = await API.getAllOrders();
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    if (res != null) {
      status = res['success'];
      cartList = res['data'];
      setState(() {});
    }
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildAppBarForPages(
                context,
                tr('orders'),
                () => scaffoldkey.currentState.openDrawer(),
              ),
              SizedBox(
                height: response.setHeight(8),
              ),
              !status
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: kprimary),
                      ),
                    )
                  : cartList.length == 0
                      ? Expanded(
                          child: Center(
                            child: buildText("No Orders Found ...."),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            itemBuilder: (c, i) => buildOrderItem(cartList[i]),
                            itemCount: cartList.length,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
