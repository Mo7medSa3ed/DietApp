import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/main.dart';
import 'package:flutter_test_app/pages/acheive.dart';
import 'package:flutter_test_app/pages/course.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineScrean extends StatefulWidget {
  final id;
  final start;
  final name;
  final nextdayId;
  TimeLineScrean(this.id, this.name, this.start, this.nextdayId);
  @override
  _TimeLineScreanState createState() => _TimeLineScreanState();
}

class _TimeLineScreanState extends State<TimeLineScrean> {
/*
 * save RecommendedCourseID 
 * save day
 * save DoneIds 
 * {
  'rcId':'',
  'currantday':''
  'doneIds':[]
}
 */

  final scaffoldkey = GlobalKey<ScaffoldState>();
  int press = 0;

  var courseDayList = [];
  var status = false;
  var isRtl = false;
  var rc;

  getData() async {
    // if (widget.nextdayId != null)
    // await saveRecommendedCourse(doneDayId: widget.nextdayId.toString());
    rc = await getSavedRecommendedCourse();

    courseDayList = [];
    final res = await API.getOneCourseDays(widget.id);
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    if (res != null) {
      status = res['success'];
      if (res['data'].length > 0) {
        res['data'].forEach((k, v) {
          courseDayList.add({
            "day": k,
            "isDone": (rc['doneDaysIds'].contains(k
                    .toString()) /* &&
                widget.nextdayId != null &&
                k.toString() != widget.nextdayId.toString()), */
                ),
            "value": v
                .map((e) => {
                      "id": e['id'],
                      "done": rc['doneIds'].contains(e['id'].toString()),
                      "name": e['name'],
                      "time": e['from_time'].substring(0, 5),
                      "items": e['components'].map((e) => e).toList()
                    })
                .toList()
          });
        });
        print(rc);
        if (widget.start == null) {
          int idx = courseDayList.indexWhere((e) => e['isDone'] == false);
          press = idx != -1 ? idx : 0;
        } else
          press = widget.start;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future saveRecommendedCourse({String doneId, String doneDayId}) async {
    final prefs = await SharedPreferences.getInstance();
    var res = prefs.getString('rc');
    var r = {'rcId': widget.id, 'doneDaysIds': [], 'doneIds': []};
    if (res == null || res.trim().isEmpty) {
      await prefs.setString('rc', jsonEncode(r));
      res = jsonEncode(r);
    }
    final response = jsonDecode(res);
    if (doneDayId != null) {
      if (!response['doneDaysIds'].contains(doneDayId.toString()))
        response['doneDaysIds'].add(doneDayId.toString());
    }
    if (doneId != null) {
      if (!response['doneIds'].contains(doneId.toString()))
        response['doneIds'].add(doneId.toString());
    }
    await prefs.setString('rc', jsonEncode(response));
  }

  Future getSavedRecommendedCourse() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('rc', '');
    final res = prefs.getString('rc');

    if (res == null || res.trim().isEmpty) {
      return {'rcId': widget.id, 'doneDaysIds': [], 'doneIds': []};
    }
    return jsonDecode(res);
  }

  @override
  Widget build(BuildContext context) {
    isRtl = context.locale == Locale('ar');

    return WillPopScope(
      onWillPop: () {
        goToWithRemoveUntill(context, HomeScrean());
        goTo(context, CouresScrean());
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldkey,
          drawer: buildDrawer(context),
          backgroundColor: kcolor1,
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
            )),
            child: !status
                ? Column(
                    children: [
                      buildAppBarForPages(
                        context,
                        widget.name,
                        () => scaffoldkey.currentState.openDrawer(),
                      ),
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(color: kprimary),
                        ),
                      ),
                    ],
                  )
                : courseDayList.length == 0
                    ? Column(
                        children: [
                          buildAppBarForPages(context, widget.name,
                              () => scaffoldkey.currentState.openDrawer(),
                              marginHorizental: 16.0),
                          Expanded(
                            child: Center(
                              child: buildText(tr("nodata")),
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildAppBarForPages(context, widget.name,
                                  () => scaffoldkey.currentState.openDrawer(),
                                  marginHorizental: 16.0),
                              Container(
                                height: 80,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: /* kprimary2, */ kscaffoldcolor,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(width: 3, color: kwhite),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: List.generate(
                                            courseDayList.length,
                                            (index) => Container(
                                                  decoration: BoxDecoration(
                                                      color: press > index
                                                          ? kscaffoldcolor
                                                          : kprimary2,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight: context
                                                                    .locale ==
                                                                Locale('en')
                                                            ? Radius.circular(
                                                                20)
                                                            : Radius.zero,
                                                        bottomRight: context
                                                                    .locale ==
                                                                Locale('en')
                                                            ? Radius.circular(
                                                                20)
                                                            : Radius.zero,
                                                        topLeft: context
                                                                    .locale !=
                                                                Locale('en')
                                                            ? Radius.circular(
                                                                20)
                                                            : Radius.zero,
                                                        bottomLeft: context
                                                                    .locale !=
                                                                Locale('en')
                                                            ? Radius.circular(
                                                                20)
                                                            : Radius.zero,
                                                      )),
                                                  child: InkWell(
                                                    onTap: () {
                                                      int idx =
                                                          rc['doneDaysIds']
                                                              .length;
                                                      if (index - idx == 1) {
                                                        if (rc['doneDaysIds']
                                                                .contains(
                                                                    courseDayList[
                                                                            index]
                                                                        [
                                                                        'day']) ||
                                                            (index - idx == 1 &&
                                                                rc['doneDaysIds']
                                                                    .contains(courseDayList[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'day']))) {
                                                          setState(() {
                                                            press = index;
                                                          });
                                                        } else
                                                          return;
                                                      } else {
                                                        setState(() {
                                                          press = index;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: press == index
                                                            ? kblue
                                                            : index > press
                                                                ? kscaffoldcolor
                                                                : kprimary2,
                                                        borderRadius: press ==
                                                                index
                                                            ? BorderRadius
                                                                .circular(20)
                                                            : index ==
                                                                    courseDayList
                                                                            .length -
                                                                        1
                                                                ? BorderRadius.only(
                                                                    topRight: context.locale == Locale('en')
                                                                        ? Radius.circular(
                                                                            20)
                                                                        : Radius
                                                                            .zero,
                                                                    bottomRight: context.locale == Locale('en')
                                                                        ? Radius.circular(
                                                                            20)
                                                                        : Radius
                                                                            .zero,
                                                                    topLeft: context.locale != Locale('en')
                                                                        ? Radius.circular(
                                                                            20)
                                                                        : Radius
                                                                            .zero,
                                                                    bottomLeft: context.locale !=
                                                                            Locale('en')
                                                                        ? Radius.circular(20)
                                                                        : Radius.zero)
                                                                : null,
                                                        border: press == index
                                                            ? Border.all(
                                                                width: 2,
                                                                color: kwhite)
                                                            : null,
                                                      ),
                                                      child: Center(
                                                          child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Text(
                                                              tr('day') +
                                                                  "\n${courseDayList[index]['day']}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 16,
                                                                  color:
                                                                      kwhite),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                          (press == index ||
                                                                  index ==
                                                                      press -
                                                                          1 ||
                                                                  index ==
                                                                      courseDayList
                                                                              .length -
                                                                          1)
                                                              ? Container()
                                                              : Container(
                                                                  height: 30,
                                                                  child:
                                                                      VerticalDivider(
                                                                    thickness:
                                                                        2,
                                                                    color: kwhite
                                                                        .withOpacity(
                                                                            0.6),
                                                                  ),
                                                                )
                                                        ],
                                                      )),
                                                    ),
                                                  ),
                                                ))),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildExpandedForRow(
                                        text:
                                            "${(((press) / courseDayList.length) * 100).toStringAsFixed(0)} % " +
                                                tr('complete'),
                                        color: kprimary2),
                                    buildExpandedForRow(
                                        text: "$press " + tr('days_left'),
                                        color: kblue)
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    tr("today"),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  )),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                      children: courseDayList[press]['value']
                                          .map<Widget>((e) =>
                                              buldcardForcourseitem(e['items'],
                                                  i: courseDayList[press]
                                                          ['value']
                                                      .indexOf(e)))
                                          .toList())),
                            ],
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  Widget buildRowforTimer({text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("assets/images/timer.png"),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "$text",
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 16, color: ksecondary),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDonerow({isDone = false, ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              tr('done'),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: kwhite),
                  shape: BoxShape.circle,
                  color: kwhite,
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/${isDone ? "greendone.png" : "greydone.png"}"))),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRowwithindicator({index, firsttext, seconttext, isDone = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 5,
        ),
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: isDone ? kgreen : kbackcolor),
          child: Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: isDone ? kgreen : kcolor1),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            firsttext,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: kprimary),
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            seconttext,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: ksecondary),
          ),
        )
      ],
    );
  }

  Widget buldcardForcourseitem(products, {i = 0}) {
    var isDone = courseDayList[press]['value'][i]['done'];
    var name = courseDayList[press]['value'][i]['name'];
    var time = courseDayList[press]['value'][i]['time'];
    return Column(children: [
      buildRowwithindicator(
          firsttext: name, seconttext: time, index: 0, isDone: isDone),
      ...List.generate(products.length, (index) {
        var time;
        var items = [];
        final item = products[index];
        if (item['type'] == 'and' || item['type'] == 'or') {
          items = item['items'];
        } else {
          items = [item['items']];
        }

        return Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: TimelineTile(
            alignment: TimelineAlign.start,
            hasIndicator: false,
            beforeLineStyle: LineStyle(
                color: isDone ? kgreen : ksecondary.withOpacity(0.5),
                thickness: isDone ? 5 : 3),
            endChild: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildItemForCourse(items, item['type']),
                    time != null
                        ? buildRowforTimer(text: time.toString())
                        : Container(),
                  ],
                ),
                if (index == products.length - 1)
                  buildDonerow(
                      isDone: isDone,
                      ontap: () async {
                        if (rc['doneDaysIds'].length > 0 &&
                            rc['doneDaysIds']
                                .contains(courseDayList[press]['day'])) return;

                        courseDayList[press]['value'][i]['done'] =
                            !courseDayList[press]['value'][i]['done'];

                        var id = courseDayList[press]['value'][i]['id'];
                        print(id);
                        if (i == courseDayList[press]['value'].length - 1) {
                          await saveRecommendedCourse(
                              doneId: id.toString(),
                              doneDayId: courseDayList[press]['day']);
                        } else {
                          await saveRecommendedCourse(doneId: id.toString());
                        }

                        setState(() {});
                        if (i == courseDayList[press]['value'].length - 1) {
                          return goTo(
                              context,
                              AchieveScrean(
                                  (((press + 1) / courseDayList.length) * 100)
                                      .toStringAsFixed(0),
                                  widget.id,
                                  widget.name,
                                  press == courseDayList.length - 1
                                      ? -1
                                      : press,
                                  press != courseDayList.length - 1
                                      ? courseDayList[press + 1]['day']
                                      : null));
                        }
                      })
              ],
            ),
          ),
        );
      }),
    ]);
  }

  Widget buildItemForCourse(products, type) {
    return Container(
      margin: EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: isArabic
              ? 0
              : type == 'wait'
                  ? 0
                  : 32,
          right: isArabic
              ? type == 'wait'
                  ? 0
                  : 32
              : 0),
      padding: EdgeInsets.all(12),
      decoration: type == 'wait'
          ? null
          : BoxDecoration(
              color: kwhite,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: kcolor1,
                    offset: Offset(0, 7),
                    blurRadius: 10,
                    spreadRadius: 5)
              ],
            ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(products.length, (index) {
            if (type == 'wait') {
              return buildRowforTimer(text: products[index]['name']);
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildrowForCousritem(
                  'https://clean.forever-affiliate.com/' +
                          products[index]['photo'] ??
                      "",
                  products[index]['name'] ?? "",
                  products[index]['description'] ?? "",
                ),
                index == products.length - 1
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(
                          left: 125,
                        ),
                        child: type == 'or'
                            ? Text(
                                "Or",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kprimary2,
                                    fontWeight: FontWeight.w900),
                              )
                            : type.toString().toLowerCase().trim() == 'and'
                                ? Container(
                                    height: 23,
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Icon(
                                      Icons.add,
                                      color: kprimary2,
                                    ),
                                  )
                                : Container(),
                      ),
              ],
            );
          })
        ],
      ),
    );
  }

  Widget buildrowForCousritem(img, title, desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 70,
          width: 70,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kcolor1.withOpacity(0.5)),
          child: Image.network(img),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18, color: kprimary, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                desc,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    color: ksecondary,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildExpandedForRow({text, color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 6),
          height: 15,
          width: 15,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 16, color: ksecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
