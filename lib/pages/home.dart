import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:response/response.dart';

class HomeScrean extends StatefulWidget {
  @override
  _HomeScreanState createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          drawer: buildDrawer(context),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [kcolor1, Colors.grey[300], kcolor1])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppBar(() {
                  scaffoldKey.currentState.openDrawer();
                }, context),
                SizedBox(
                  height: response.setHeight(20),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: buildText("Recommended"),
                ),
                SizedBox(
                  height: response.setHeight(20),
                ),
                Container(
                  height: response.screenHeight * 0.25,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      primary: true,
                      itemBuilder: (ctx, i) => Container(
                            margin: EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/image1.png"),
                                    scale: 2,
                                    fit: BoxFit.fill),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xff232749),
                                      Color(0xff34386e),
                                      Color(0xff232749),
                                    ]),
                                borderRadius: BorderRadius.circular(30)),
                            width: response.screenWidth - 32,
                            height: response.setHeight(200),
                          )),
                ),
                SizedBox(
                  height: response.setHeight(20),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: buildText("Courses")),
                SizedBox(
                  height: response.setHeight(20),
                ),
                buildSearch(hint: "search"),
                SizedBox(
                  height: response.setHeight(20),
                ),
                Container(
                  height: response.screenHeight * 0.25,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      primary: true,
                      itemBuilder: (ctx, i) => Stack(children: [
                            Container(
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/image2.png"),
                                      fit: BoxFit.fill),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0xff232749),
                                        Color(0xff34386e),
                                        Color(0xff232749),
                                      ]),
                                  borderRadius: BorderRadius.circular(40)),
                              width: response.screenWidth * 0.6,
                              height: response.setHeight(150),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                height: response.setHeight(75),
                                width: response.screenWidth * 0.6,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildText("FIT 15", fontsize: 22.0),
                                    buildText2("15 Days", fontsize: 16.0),
                                  ],
                                ),
                              ),
                            )
                          ])),
                )
              ],
            ),
          )),
    );
  }
}
