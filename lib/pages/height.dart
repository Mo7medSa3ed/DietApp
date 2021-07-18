import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:height_slider/height_slider.dart';
import 'package:response/response.dart';
import 'package:weight_slider/weight_slider.dart';

class HeightScrean extends StatefulWidget {
  @override
  _HeightScreanState createState() => _HeightScreanState();
}

class _HeightScreanState extends State<HeightScrean> {
  int height = 170;
  int weight = 70;
  String img = "male 1";
  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              DelayedDisplay(
                fadeIn: true,
                fadingDuration: Duration(milliseconds: 600),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "About you",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: kprimary,
                            fontSize: response.setFontSize(28),
                            fontWeight: FontWeight.w800),
                      ),
                      SvgPicture.asset(
                        "assets/images/Group 549.svg",
                        height: 70,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        img = "male 1";
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 45,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: img == "male 1"
                              ? Border.all(color: kprimary2, width: 2)
                              : null,
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white),
                      child: SvgPicture.asset("assets/images/male.svg"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        img = "female 1";
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 45,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: img != "male 1"
                              ? Border.all(color: kprimary2, width: 2)
                              : null,
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white),
                      child: SvgPicture.asset(
                        "assets/images/female.svg",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: HeightSlider(
                        height: height,
                        personImagePath: 'assets/images/$img.svg',
                        onChange: (val) => setState(() => height = val),
                        unit: 'cm',
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                          46,
                          (index) => SizedBox(
                                width: index % 5 == 0
                                    ? 20
                                    : index % 2 == 0
                                        ? 15
                                        : 10,
                                child: Divider(
                                  color: kprimary,
                                  height: 7.5,
                                  thickness: index % 5 == 0 ? 1.8 : 1.2,
                                ),
                              )),
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                child: WeightSlider(
                  weight: weight,
                  minWeight: 40,
                  maxWeight: 120,
                  onChange: (val) => setState(() => weight = val),
                  unit: 'kg',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 32.0, bottom: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      elevation: 8,
                      backgroundColor: kwhite,
                      onPressed: () async {
                        /*  if (formKey.currentState.validate()) {
                          if (loginPressed) {
                            await login();
                          } else {
                            await signUp();
                          }
                        } */
                        goTo(context, HomeScrean());
                      },
                      child: Icon(
                        Icons.arrow_forward_sharp,
                        color: kprimary,
                      ),
                    ),
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
