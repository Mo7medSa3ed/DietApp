import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/cart.dart';
import 'package:flutter_test_app/pages/timeline.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:response/response.dart';

class CouresScrean extends StatefulWidget {
  @override
  _CouresScreanState createState() => _CouresScreanState();
}

class _CouresScreanState extends State<CouresScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  var course;
  var status = false;
  getData() async {
    // var id = Provider.of<AppProvider>(context, listen: false)
    //     .user['course_recommended'];

    final res = await API.getOneCourse(2);

    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    if (res != null) {
      status = res['success'];
      course = res['data'];
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
    final response = ResponseUI.instance;
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        drawer: buildDrawer(context),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // radius: 0.1,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xffe4e6f3),
                Color(0xfffefefe),
                Color(0xffe4e6f3),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildAppBarForPages(
                context,
                course == null ? '' : course['name'],
                () => scaffoldkey.currentState.openDrawer(),
              ),
              SizedBox(
                height: response.setHeight(30),
              ),
              !status
                  ? Center(
                      child: CircularProgressIndicator(color: kprimary),
                    )
                  : course == null
                      ? Center(
                          child: buildText(tr("nodata")),
                        )
                      : Expanded(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              Container(
                                height: response.screenHeight * 0.23 + 50,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 32,
                                      right: 32,
                                      top: 0,
                                      child: Container(
                                        height: response.screenHeight * 0.23,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
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
                                        top: 20,
                                        bottom: -10,
                                        child: Container(
                                          width: double.infinity,
                                          height: response.screenHeight * 0.23,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    course['photo'])),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment(1, -0.7),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        height: 100,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                              "assets/images/curve.png",
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${course['days']} Days",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: kwhite,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: response
                                                        .setFontSize(15)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: response.setHeight(20),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0),
                                  child: buildText2(course['description'])),
                              SizedBox(
                                height: response.setHeight(10),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0),
                                  child: buildText(tr('components'))),
                              SizedBox(
                                height: response.setHeight(10),
                              ),
                              ...List.generate(
                                  course['products'].length,
                                  (i) =>
                                      buildCourseItem(course['products'][i])),
                            ],
                          ),
                        ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: ksecondary,
                          offset: Offset(0, -5),
                          blurRadius: 10,
                          spreadRadius: 2)
                    ],
                    color: kwhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: "btn3",
                      backgroundColor: kdrawer,
                      onPressed: () => goTo(context, CartScrean()),
                      child: Image.asset("assets/images/cart.png"),
                    ),
                    SizedBox(
                      width: response.setWidth(10),
                    ),
                    Expanded(
                        child: buildIconElevatedButton(
                      icon: Icon(Icons.play_arrow),
                      label: tr('start_now'),
                      onpressed: () => goTo(
                        context,
                        TimeLineScrean(course['id'], course['name'], 0, null),
                      ),
                    ))
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
