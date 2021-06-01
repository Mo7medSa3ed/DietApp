import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/cart.dart';
// ignore: unused_import
import 'package:flutter_test_app/pages/shop.dart';
import 'package:flutter_test_app/pages/timeline.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:response/response.dart';

class CouresScrean extends StatefulWidget {
  @override
  _CouresScreanState createState() => _CouresScreanState();
}

class _CouresScreanState extends State<CouresScrean> {
  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [kcolor1, Colors.grey[200], kcolor1])),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    buildAppBarForPages(context, 'Clean 9'),
                    SizedBox(
                      height: response.setHeight(30),
                    ),
                    Container(
                      height: response.screenHeight * 0.23 + 5,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 25,
                            right: 25,
                            child: Container(
                              width: response.screenWidth - 50,
                              height: response.screenHeight * 0.23,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                      //stops: [0.5, 0.8, 0.0],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0xff232749),
                                        Color(0xff34386e),
                                        Color(0xff232749),
                                      ])),
                            ),
                          ),
                          Positioned(
                              right: 25,
                              left: 25,
                              bottom: -10,
                              top: 60,
                              child: Container(
                                width: double.infinity,
                                height: response.screenHeight * 0.23,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/images/image3.png"))),
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              "assets/images/curve.png",
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                "20 Days",
                                style: TextStyle(
                                    color: kwhite,
                                    fontWeight: FontWeight.w900,
                                    fontSize: response.setFontSize(17)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: response.setHeight(20),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: buildText2(
                            '20 Days ndakjndksank asdsadsa sadhsaldlsk')),
                    SizedBox(
                      height: response.setHeight(5),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.amber[400],
                                  )),
                        )),
                    SizedBox(
                      height: response.setHeight(10),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: buildText('Components')),
                    SizedBox(
                      height: response.setHeight(10),
                    ),
                    buildCourseItem(),
                    buildCourseItem(),
                    buildCourseItem(),
                    buildCourseItem(),
                    buildCourseItem(),
                    buildCourseItem(),
                    buildCourseItem(),
                    buildCourseItem(),
                    buildCourseItem(),
                    buildCourseItem(),
                    buildCourseItem(),
                    // Spacer(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                height: response.screenHeight * 0.12,
                decoration: BoxDecoration(
                    color: kwhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: kdrawer,
                      onPressed: () => GoTo(context, CartScrean()),
                      child: Image.asset("assets/images/cart.png"),
                    ),
                    SizedBox(
                      width: response.setWidth(20),
                    ),
                    Expanded(
                        child: buildIconElevatedButton(
                            icon: Icon(Icons.play_arrow),
                            label: 'Start Now',
                            onpressed: () => GoTo(context, TimeLineScrean())))
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

/**
 * 
 * 
 */
