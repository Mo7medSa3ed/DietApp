import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/cart.dart';
// ignore: unused_import
import 'package:flutter_test_app/pages/shop.dart';
import 'package:flutter_test_app/pages/timeline.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:provider/provider.dart';
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
    var id = Provider.of<AppProvider>(context, listen: false)
        .user['course_recommended'];

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
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [kcolor1, Colors.grey[200], kcolor1])),
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
                                        bottom: 0,
                                        top: 0,
                                        child: Container(
                                          width: double.infinity,
                                          height: response.screenHeight * 0.23,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      course['photo']))),
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        "assets/images/curve.png",
                                        height: 110,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Text(
                                          "${course['days']} Days",
                                          style: TextStyle(
                                              color: kwhite,
                                              fontWeight: FontWeight.w900,
                                              fontSize:
                                                  response.setFontSize(17)),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: buildText2(course['description'])),
                              SizedBox(
                                height: response.setHeight(10),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
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
                padding: EdgeInsets.all(16),
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
                            onpressed: () =>
                                goTo(context, TimeLineScrean(course['id'], 0))))
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
