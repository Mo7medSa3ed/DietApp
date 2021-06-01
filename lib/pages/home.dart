import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/course.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:response/response.dart';

class HomeScrean extends StatefulWidget {
  @override
  _HomeScreanState createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  List courseList = [];
  List allCourseList = [];
  @override
  void initState() {
    allCourseList = List.generate(10, (index) => "FIT ${15 + index}");
    courseList = allCourseList;
    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          drawer: buildDrawer(context),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [kcolor1, Colors.grey[300], kcolor1])),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: buildAppBar(() {
                    scaffoldKey.currentState.openDrawer();
                  }),
                ),
                SizedBox(
                  height: response.setHeight(20),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: buildText("Recommended"),
                ),
                SizedBox(
                  height: response.setHeight(20),
                ),
                InkWell(
                  onTap: () => GoTo(context, CouresScrean()),
                  child: Container(
                    margin: EdgeInsets.only(right: 24, left: 24),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xff232749),
                              Color(0xff34386e),
                              Color(0xff232749),
                            ]),
                        borderRadius: BorderRadius.circular(30)),
                    width: response.screenWidth,
                    height: response.screenHeight * 0.25,
                    child: Stack(children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              "assets/images/image1.png",
                              fit: BoxFit.fill,
                            ),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Clean 9",
                                style: TextStyle(
                                    fontSize: response.setFontSize(28),
                                    color: kwhite,
                                    fontWeight: FontWeight.w900),
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "21 Days",
                                style: TextStyle(
                                    fontSize: response.setFontSize(18),
                                    color: kprimary2,
                                    fontWeight: FontWeight.w900),
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: response.setHeight(20),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: buildText("Courses")),
                SizedBox(
                  height: response.setHeight(20),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: buildSearch(
                        hint: "search",
                        onChange: (v) {
                          if (v.toString().length > 0) {
                            courseList = allCourseList
                                .where((e) => e
                                    .toString()
                                    .toLowerCase()
                                    .trim()
                                    .contains(
                                        v.toString().toLowerCase().trim()))
                                .toList();
                          } else {
                            courseList = allCourseList;
                          }
                          setState(() {});
                        })),
                SizedBox(
                  height: response.setHeight(20),
                ),
                Container(
                  height: response.screenHeight * 0.25,
                  child: ListView.builder(
                      itemCount: courseList.length,
                      scrollDirection: Axis.horizontal,
                      primary: true,
                      itemBuilder: (ctx, i) => Stack(children: [
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
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
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Image.asset(
                                      "assets/images/icon3.png",
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(left: 16),
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
                                    buildText(courseList[i], fontsize: 22.0),
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
