import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/course.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';

class HomeScrean extends StatefulWidget {
  @override
  _HomeScreanState createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  var courseList = [];
  var allCourseList = [];
  var status = false;
  var user;
  //var _scrollController = ScrollController();
  @override
  void initState() {
    getData();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.maxScrollExtent ==
    //       _scrollController.offset) print("object");
    // });
    super.initState();
  }

  getData() async {
    final res = await API.getAllCourses();
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    if (res != null) {
      status = res['success'];
      allCourseList = res['data'] ?? [];
      courseList = res['data'] ?? [];
      Provider.of<AppProvider>(context, listen: false)
          .user['course_recommended'] = allCourseList[0]['id'];
    }
    setState(() {});
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          drawer: buildDrawer(context),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: RadialGradient(radius: 1, colors: [
              kwhite,
              kcolor1,
            ])),
            child: !status
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: buildAppBar(() {
                          scaffoldKey.currentState.openDrawer();
                        }, context),
                      ),
                      SizedBox(
                        height: response.setHeight(10),
                      ),
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: kprimary),
                        ),
                      ),
                    ],
                  )
                : allCourseList.length == 0
                    ? Center(
                        child: buildText("No Data Found ...."),
                      )
                    : ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: buildAppBar(() {
                              scaffoldKey.currentState.openDrawer();
                            }, context),
                          ),
                          SizedBox(
                            height: response.setHeight(10),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: buildText("Recommended"),
                          ),
                          SizedBox(
                            height: response.setHeight(20),
                          ),
                          InkWell(
                            onTap: () => goTo(context, CouresScrean()),
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
                                      child: Image.network(
                                        allCourseList[0]['photo'],
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          allCourseList[0]['name'],
                                          style: TextStyle(
                                              fontSize:
                                                  response.setFontSize(20),
                                              color: kwhite,
                                              fontWeight: FontWeight.w900),
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${allCourseList[0]['days']} Days",
                                          style: TextStyle(
                                              fontSize:
                                                  response.setFontSize(15),
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
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: ksecondary.withOpacity(0.3),
                                      offset: Offset(0, 0),
                                      blurRadius: 15,
                                      spreadRadius: 5)
                                ],
                              ),
                              child: buildSearch(
                                  hint: "search",
                                  onChange: (v) {
                                    if (v.toString().length > 0) {
                                      courseList = allCourseList
                                          .where((e) => e['name']
                                              .toString()
                                              .toLowerCase()
                                              .trim()
                                              .contains(v
                                                  .toString()
                                                  .toLowerCase()
                                                  .trim()))
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
                                physics: BouncingScrollPhysics(),
                                // controller: _scrollController,
                                itemCount: courseList.length,
                                scrollDirection: Axis.horizontal,
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
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        width: response.screenWidth * 0.6,
                                        height: response.setHeight(150),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              top: 0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.network(
                                                  courseList[i]['photo'],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 16,
                                              right:
                                                  (i == courseList.length - 1)
                                                      ? 16
                                                      : 0),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          height: response.setHeight(65),
                                          width: response.screenWidth * 0.6,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  bottomRight:
                                                      Radius.circular(30))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              buildText(courseList[i]['name'],
                                                  fontsize: 14.0),
                                              buildText2(
                                                  "${courseList[i]['days']} Days",
                                                  fontsize: 12.0),
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
