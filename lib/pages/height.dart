import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:height_slider/height_slider.dart';
import 'package:provider/provider.dart';
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
  var user;
  @override
  void initState() {
    user = Provider.of<AppProvider>(context, listen: false).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;

    return SafeArea(
      child: Scaffold(
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
                      InkWell(
                        onTap: () async => await updateUser(),
                        child: SvgPicture.asset(
                          "assets/images/Group 549.svg",
                          height: 70,
                        ),
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
                child: HeightSlider(
                  height: height,
                  personImagePath: 'assets/images/$img.svg',
                  onChange: (val) => setState(() => height = val),
                  unit: 'cm',
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: List.generate(
              //       46,
              //       (index) => SizedBox(
              //             width: index % 5 == 0
              //                 ? 20
              //                 : index % 2 == 0
              //                     ? 15
              //                     : 10,
              //             child: Divider(
              //               color: kprimary,
              //               height: 7.5,
              //               thickness: index % 5 == 0 ? 1.8 : 1.2,
              //             ),
              //           )),
              // ),

              Container(
                height: MediaQuery.of(context).size.height * 0.29,
                child: Stack(
                  children: [
                    Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.2 / -2,
                        left: MediaQuery.of(context).size.width * 0.2,
                        right: MediaQuery.of(context).size.width * 0.2,
                        child: SvgPicture.asset(
                          "assets/images/weight.svg",
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height * 0.3,
                        )),
                    Align(
                      alignment: Alignment(0, -0.3),
                      child: WeightSlider(
                        weight: weight,
                        minWeight: 40,
                        maxWeight: 120,
                        onChange: (val) => setState(() => weight = val),
                        unit: 'kg',
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment(0.75, 0.6),
                    //   child: FloatingActionButton(
                    //     elevation: 8,
                    //     backgroundColor: kwhite,
                    //     onPressed: () async {
                    //       user =
                    //           Provider.of<AppProvider>(context, listen: false)
                    //               .user;
                    //       await updateUser();
                    //     },
                    //     child: Icon(
                    //       Icons.arrow_forward_sharp,
                    //       color: kprimary,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(right: 32.0, bottom: 32),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       FloatingActionButton(
              //         elevation: 8,
              //         backgroundColor: kwhite,
              //         onPressed: () async {
              //           user = Provider.of<AppProvider>(context, listen: false)
              //               .user;
              //           await updateUser();
              //         },
              //         child: Icon(
              //           Icons.arrow_forward_sharp,
              //           color: kprimary,
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  updateUser() async {
    Alert.loadingAlert(ctx: context);
    final body = {
      "name": user['name'].trim(),
      "mobile": user['mobile'].trim(),
      "id": user['id'],
      "weight": weight,
      "height": height,
    };
    final res = await API.updateProfile(body);
    Navigator.of(context).pop();
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    final resBody = res.data;
    if ((res.statusCode == 200 || res.statusCode == 201) &&
        resBody['success']) {
      await setValue(key: 'user', value: json.encode(resBody['data']));
      Provider.of<AppProvider>(context, listen: false)
          .initUser(resBody['data']);
    }
    goToWithRemoveUntill(context, HomeScrean());
  }
}
