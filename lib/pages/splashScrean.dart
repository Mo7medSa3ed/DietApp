import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/pages/login.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:provider/provider.dart';

class SplashScrean extends StatefulWidget {
  @override
  _SplashScreanState createState() => _SplashScreanState();
}

class _SplashScreanState extends State<SplashScrean> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final d = DateTime.now();
      getData();
      if (d.day == 8 && d.month == 9 && d.year == 2021) {}
    });
  }

  getData() async {
    // await clear();
    final user = await getValue(key: 'user');
    final token = await getValue(key: 'token');
    if (user != null && token != null) {
      Provider.of<AppProvider>(context, listen: false)
          .initUser(jsonDecode(user));
      goToWithReplace(context, HomeScrean());
    } else {
      goToWithReplace(context, LoginScrean());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/diet.svg",
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    buildText("Diet App", fontsize: 22.0),
                  ],
                ),
                CircularProgressIndicator(
                  color: kprimary,
                )
              ],
            )));
  }
}
