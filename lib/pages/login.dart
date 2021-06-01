import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:response/response.dart';

class LoginScrean extends StatefulWidget {
  @override
  _LoginScreanState createState() => _LoginScreanState();
}

class _LoginScreanState extends State<LoginScrean> {
  bool loginPressed = true;
  double loginAlignment = -0.5;
  double trans = -0.15;

  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: DelayedDisplay(
                    fadeIn: true,
                    fadingDuration: Duration(seconds: 2),
                    child: Align(
                      alignment: Alignment(-0.84, -0.9),
                      child: Text(
                        "Welcome !",
                        style: TextStyle(
                            fontSize: response.setFontSize(30),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),

                
              ],
            )));
  }
}
