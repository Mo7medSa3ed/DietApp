import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/pages/timeline.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class AchieveScrean extends StatefulWidget {
  final percent;
  final end;
  final id;
  final name;
  final nextdayId;
  AchieveScrean(this.percent, this.id, this.name, this.end, this.nextdayId);
  @override
  _AchieveScreanState createState() => _AchieveScreanState();
}

class _AchieveScreanState extends State<AchieveScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  bool isBoy = false;

  @override
  void initState() {
    isBoy = Provider.of<AppProvider>(context, listen: false).user['gender'] ==
            "male"
        ? true
        : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => goToWithRemoveUntill(context, HomeScrean()),
      child: SafeArea(
        child: Scaffold(
          key: scaffoldkey,
          drawer: buildDrawer(context),
          backgroundColor: Color(0xff232749),
          body: Stack(children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          stops: [0.5, 0.8, 0.0],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xff232749),
                            Color(0xff34386e),
                            Color(0xff232749),
                          ])),
                )),
            Align(
              alignment: Alignment(0, 0.5),
              child: Text(
                tr('achived'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: response.setFontSize(22),
                    fontWeight: FontWeight.w800,
                    color: kwhite.withOpacity(0.9)),
              ),
            ),
            Align(
                alignment: Alignment(0, 0.68),
                child: Text(
                  "${widget.percent} %",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'RifficFree',
                      fontSize: response.setFontSize(45),
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                )),
            Align(
              alignment: Alignment(0, 0.88),
              child: Text(
                widget.end == -1 ? tr('finish') : tr('next'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: response.setFontSize(22),
                    fontWeight: FontWeight.w800,
                    color: kwhite.withOpacity(0.9)),
              ),
            ),
            Align(
                alignment: Alignment(
                    context.locale == Locale('ar') ? -0.85 : 0.85, 0.9),
                child: Container(
                  width: 65,
                  height: 65,
                  child: FloatingActionButton(
                    heroTag: "btn1",
                    mini: false,
                    onPressed: () async {
                      return widget.end == -1
                          ? goToWithRemoveUntill(context, HomeScrean())
                          : goTo(
                              context,
                              TimeLineScrean(widget.id, widget.name,
                                  widget.end + 1, widget.nextdayId));
                    },
                    backgroundColor: kwhite,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: kprimary2,
                      size: 35,
                    ),
                  ),
                )),
            ClipPath(
              clipper: CustumLinearclipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.0, -0.1),
                    radius: 0.9,
                    colors: [kwhite, ksecondary],
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: buildAppBarForPages(
                        context,
                        'Clean 9',
                        () => scaffoldkey.currentState.openDrawer(),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -0.75),
                      child: Text(
                        tr('great'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'RifficFree',
                            fontSize: response.setFontSize(40),
                            fontWeight: FontWeight.w800,
                            letterSpacing: 4,
                            color: kprimary),
                      ),
                    ),
                    Align(
                        alignment: Alignment(-0.13, -0.26),
                        child: CircularPercentIndicator(
                          radius: response.screenWidth * 0.65,
                          lineWidth: response.screenWidth * 0.1 / 3 * 2.2,
                          percent: double.parse(widget.percent) / 100,
                          arcType: ArcType.HALF,
                          arcBackgroundColor: kcolor1,
                          circularStrokeCap: CircularStrokeCap.round,
                          linearGradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 63, 84, 202),
                              Color.fromARGB(255, 89, 114, 251),
                            ],
                          ),
                        )),
                    Align(
                        alignment:
                            isBoy ? Alignment(0.1, 0.2) : Alignment(-0.1, 0.3),
                        child: Image.asset(
                          "assets/images/${(isBoy ? 'boy' : "girl")}.png",
                          height: response.screenHeight * 0.4,
                        )),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
