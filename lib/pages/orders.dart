import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/widgets/custum.dart';

class OrderScrean extends StatefulWidget {
  @override
  _OrderScreanState createState() => _OrderScreanState();
}

class _OrderScreanState extends State<OrderScrean> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [kcolor1, Colors.grey[200], kcolor1])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildAppBarForPages(context, 'Orders'),
              SizedBox(
                height: response.setHeight(8),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (c, i) => buildOrderItem(),
                  itemCount: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
