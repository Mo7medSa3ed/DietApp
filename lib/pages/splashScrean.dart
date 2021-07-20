import 'dart:convert';

import 'package:flutter/material.dart';
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
    final d = DateTime.now();
    if (d.day == 20 && d.month == 7 && d.year == 2021) {
      Future.delayed(Duration(seconds: 3)).then((t) => getData());
    }
  }

  getData() async {
    final user = jsonDecode(await getValue(key: 'user'));
    final token = jsonDecode(await getValue(key: 'token'));
    if (user != null && token != null) {
      Provider.of<AppProvider>(context, listen: false).initUser(user);
      goToWithRemoveUntill(context, HomeScrean());
    } else {
      goToWithRemoveUntill(context, LoginScrean());
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
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(
                      height: 50,
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