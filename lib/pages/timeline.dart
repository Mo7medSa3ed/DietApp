import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/acheive.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineScrean extends StatefulWidget {
  @override
  _TimeLineScreanState createState() => _TimeLineScreanState();
}

class _TimeLineScreanState extends State<TimeLineScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  int press = -1;
  var idxList = [];
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
          child: SingleChildScrollView(
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
                    color: kscaffoldcolor,
                    border: Border.symmetric(
                        horizontal: BorderSide(width: 2, color: kwhite)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            10,
                            (index) => Container(
                                  decoration: BoxDecoration(
                                    color: press != index || index > 3
                                        ? kscaffoldcolor
                                        : kprimary2,
                                    borderRadius: (press == index && index > 3)
                                        ? BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20))
                                        : null,
                                  ),
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
                                            : index < 5
                                                ? kprimary2
                                                : kscaffoldcolor,
                                        borderRadius: press == index
                                            ? BorderRadius.circular(20)
                                            : null,
                                        border: press == index
                                            ? Border.all(
                                                width: 2, color: kwhite)
                                            : null,
                                      ),
                                      child: Center(
                                          child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              "Day\n18",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 16,
                                                  color: kwhite),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          (press == index ||
                                                  index == press - 1 ||
                                                  index == 9)
                                              ? Container()
                                              : Container(
                                                  height: 30,
                                                  child: VerticalDivider(
                                                    thickness: 2,
                                                    color:
                                                        kwhite.withOpacity(0.6),
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
                          text: "20 % Complete", color: kprimary2),
                      buildExpandedForRow(text: "6 Days Left", color: kblue)
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Today",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    )),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...List.generate(
                          3,
                          (index) => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildRowwithindicator(
                                      index: index,
                                      firsttext: "Breakfast",
                                      seconttext: "12:00 AM"),
                                  buldcardForcourseitem(
                                      img: "assets/images/image4.png",
                                      title: "Breakfast",
                                      desc: "ohhh yaa",
                                      time: '20',
                                      index: index),
                                ],
                              )),
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
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Done",
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
              color: idxList.contains(index) ? kgreen : kbackcolor),
          child: Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: idxList.contains(index) ? kgreen : kcolor1),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            firsttext,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: kprimary),
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            seconttext,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: ksecondary),
          ),
        )
      ],
    );
  }

  Widget buldcardForcourseitem({img, title, desc, time, index}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: TimelineTile(
        alignment: TimelineAlign.start,
        hasIndicator: false,
        beforeLineStyle: LineStyle(
            color:
                idxList.contains(index) ? kgreen : ksecondary.withOpacity(0.5),
            thickness: idxList.contains(index) ? 5 : 3),
        endChild: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
                4,
                (index) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildItemForCourse(img, title, desc, index),
                        time != null
                            ? buildRowforTimer(text: time.toString())
                            : Container(),
                      ],
                    )),
            buildDonerow(
                isDone: idxList.contains(index),
                ontap: () {
                  setState(() {
                    idxList.contains(index)
                        ? idxList.remove(index)
                        : idxList.add(index);
                  });
                  Timer.periodic(Duration(seconds: 1), (t) {
                    t.cancel();
                    goTo(context, AchieveScrean());
                  });
                })
          ],
        ),
      ),
    );
  }

  Widget buildItemForCourse(img, title, desc, index) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 15),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildrowForCousritem(img, title, desc),
          ...index > 1
              ? List.generate(
                  3,
                  (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 125),
                        child: index > 1
                            ? Text(
                                "Or",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kprimary2,
                                    fontWeight: FontWeight.w900),
                              )
                            : Container(
                                height: 23,
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Image.asset(
                                  "assets/images/plus.png",
                                ),
                              ),
                      ),
                      buildrowForCousritem(img, title, desc),
                    ],
                  ),
                )
              : []
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
          child: Image.asset(img),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
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
                  fontSize: 18, color: ksecondary, fontWeight: FontWeight.w900),
            ),
          ],
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
