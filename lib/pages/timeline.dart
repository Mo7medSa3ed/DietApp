import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/acheive.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineScrean extends StatefulWidget {
  final id;
  final start;
  TimeLineScrean(this.id, this.start);
  @override
  _TimeLineScreanState createState() => _TimeLineScreanState();
}

class _TimeLineScreanState extends State<TimeLineScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  int press;

  var courseDayList = [];
  var status = false;

  getData() async {
    courseDayList = [];
    final res = await API.getOneCourseDays(widget.id);
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    if (res != null) {
      status = res['success'];
      if (res['data'].length > 0)
        res['data'].forEach((k, v) {
          courseDayList.add({
            "day": k,
            "value": v[0]['components']
                .map((e) => {"item": e, "done": false})
                .toList()
          });
        });
    }
    setState(() {});
  }

  @override
  void initState() {
    press = widget.start ?? 0;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        drawer: buildDrawer(context),
        backgroundColor: kcolor1,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [kcolor1, Colors.grey[200], kcolor1])),
          child: !status
              ? Column(
                  children: [
                    buildAppBarForPages(
                      context,
                      "Clean 9",
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
                        buildAppBarForPages(
                          context,
                          "Clean 9",
                          () => scaffoldkey.currentState.openDrawer(),
                        ),
                        Expanded(
                          child: Center(
                            child: buildText(tr("nodata")),
                          ),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildAppBarForPages(
                            context,
                            "Clean 9",
                            () => scaffoldkey.currentState.openDrawer(),
                          ),
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: /* kprimary2, */ kscaffoldcolor,
                              borderRadius: BorderRadius.circular(20),
                              // border: Border.symmetric(
                              //     horizontal: BorderSide(width: 2, color: kwhite)),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(
                                      courseDayList.length,
                                      (index) => Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    /* press != index || index > 3
                                        ? kscaffoldcolor
                                        : */
                                                    press > index
                                                        ? kscaffoldcolor
                                                        : kprimary2,
                                                borderRadius:
                                                    /*  (press ==
                                            index /*  && index > 3 */)
                                        ? */
                                                    BorderRadius.only(
                                                  topRight: context.locale ==
                                                          Locale('en')
                                                      ? Radius.circular(20)
                                                      : Radius.zero,
                                                  bottomRight: context.locale ==
                                                          Locale('en')
                                                      ? Radius.circular(20)
                                                      : Radius.zero,
                                                  topLeft: context.locale !=
                                                          Locale('en')
                                                      ? Radius.circular(20)
                                                      : Radius.zero,
                                                  bottomLeft: context.locale !=
                                                          Locale('en')
                                                      ? Radius.circular(20)
                                                      : Radius.zero,
                                                )),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  press = index;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: press == index
                                                      ? kblue
                                                      /* : index < 5
                                                ? kprimary2 */
                                                      : index > press
                                                          ? kscaffoldcolor
                                                          : kprimary2, //kscaffoldcolor,
                                                  borderRadius: press == index
                                                      ? BorderRadius.circular(
                                                          20)
                                                      : index ==
                                                              courseDayList.length -
                                                                  1
                                                          ? BorderRadius.only(
                                                              topRight: context.locale == Locale('en')
                                                                  ? Radius.circular(
                                                                      20)
                                                                  : Radius.zero,
                                                              bottomRight: context
                                                                          .locale ==
                                                                      Locale(
                                                                          'en')
                                                                  ? Radius.circular(
                                                                      20)
                                                                  : Radius.zero,
                                                              topLeft: context.locale !=
                                                                      Locale(
                                                                          'en')
                                                                  ? Radius.circular(
                                                                      20)
                                                                  : Radius.zero,
                                                              bottomLeft: context
                                                                          .locale !=
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
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Text(
                                                        tr('day') +
                                                            "\n${courseDayList[index]['day']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 16,
                                                            color: kwhite),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    (press == index ||
                                                            index ==
                                                                press - 1 ||
                                                            index ==
                                                                courseDayList
                                                                        .length -
                                                                    1)
                                                        ? Container()
                                                        : Container(
                                                            height: 30,
                                                            child:
                                                                VerticalDivider(
                                                              thickness: 2,
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
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    fontSize: 20, fontWeight: FontWeight.w900),
                              )),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...List.generate(
                                    courseDayList[press]['value'].length, (i) {
                                  var m;
                                  final product =
                                      courseDayList[press]['value'][i]['item'];
                                  if (product['type'] == 'and' ||
                                      product['type'] == 'or') {
                                    m = product['items'];
                                  } else {
                                    m = [product['items']];
                                  }

                                  print(m);

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildRowwithindicator(
                                          index: i,
                                          firsttext: getMealName(1),
                                          seconttext: "02:30 AM"),
                                      // buildRowwithindicator(
                                      //     index: i,
                                      //     firsttext: getMealName(int.parse(
                                      //         m['time'].substring(0, 2))),
                                      //     seconttext:
                                      //         "${m['time'].substring(0, 5)} AM"),
                                      buldcardForcourseitem(
                                          index: i, products: m),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  getMealName(num) {
    if (num > 1)
      return tr("launch");
    else if (num < 1) return tr("breakfast");
    return tr("dinner");
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
              "Wait $text Minutes",
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
              tr('ok'),
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

  Widget buildRowwithindicator({index, firsttext, seconttext}) {
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
              shape: BoxShape.circle,
              color: courseDayList[press]['value'][index]['done']
                  ? kgreen
                  : kbackcolor),
          child: Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: courseDayList[press]['value'][index]['done']
                    ? kgreen
                    : kcolor1),
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

  Widget buldcardForcourseitem({time, index, products}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TimelineTile(
        alignment: TimelineAlign.start,
        hasIndicator: false,
        beforeLineStyle: LineStyle(
            color: courseDayList[press]['value'][index]['done']
                ? kgreen
                : ksecondary.withOpacity(0.5),
            thickness: courseDayList[press]['value'][index]['done'] ? 5 : 3),
        endChild: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildItemForCourse(products, index),
                time != null
                    ? buildRowforTimer(text: time.toString())
                    : Container(),
              ],
            ),
            buildDonerow(
                isDone: courseDayList[press]['value'][index]['done'],
                ontap: () {
                  courseDayList[press]['value'][index]['done'] =
                      !courseDayList[press]['value'][index]['done'];
                  if (index == courseDayList[press]['value'].length - 1) {
                    return goTo(
                        context,
                        AchieveScrean(
                            (((press + 1) / courseDayList.length) * 100)
                                .toStringAsFixed(0),
                            widget.id,
                            press == courseDayList.length - 1 ? -1 : press));
                  }

                  setState(() {});
                })
          ],
        ),
      ),
    );
  }

  Widget buildItemForCourse(products, i) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
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
          ...List.generate(
            products.length,
            (index) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildrowForCousritem(
                  products[index]['photo'] ?? "",
                  products[index]['name'] ?? "",
                  products[index]['description'] ?? "",
                ),
                index == products.length - 1
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(
                          left: 125,
                        ),
                        child: courseDayList[press]['value'][i]['item']
                                    ['type'] ==
                                'or'
                            ? Text(
                                "Or",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kprimary2,
                                    fontWeight: FontWeight.w900),
                              )
                            : courseDayList[press]['value'][i]['item']['type']
                                        .toString()
                                        .toLowerCase()
                                        .trim() ==
                                    'and'
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
            ),
          )
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
