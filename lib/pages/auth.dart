import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:response/response.dart';

class AuthScrean extends StatefulWidget {
  @override
  _AuthScreanState createState() => _AuthScreanState();
}

class _AuthScreanState extends State<AuthScrean> {
  bool loginPressed = true;
  double loginAlignment = -0.53;
  double trans = -0.42;

  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Stack(
            children: [
              DelayedDisplay(
                fadeIn: true,
                fadingDuration: Duration(seconds: 1),
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
              AnimatedAlign(
                duration: Duration(milliseconds: 180),
                alignment:
                    Alignment(-0.5, loginPressed ? loginAlignment : -0.5),
                child: GestureDetector(
                  onTap: () {
                    if (!loginPressed) {
                      loginPressed = !loginPressed;
                      trans = -0.42;
                      loginAlignment = -0.53;
                      setState(() {});
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(
                        horizontal: !loginPressed ? 0 : 25,
                        vertical: !loginPressed ? 0 : 9),
                    decoration: BoxDecoration(
                        color: loginPressed ? kprimary2 : null,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color:
                              loginPressed ? kwhite.withOpacity(0.9) : kprimary,
                          fontSize: response.setFontSize(13),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              AnimatedAlign(
                duration: Duration(milliseconds: 250),
                alignment: Alignment(0.5, loginPressed ? -0.5 : loginAlignment),
                child: GestureDetector(
                  onTap: () {
                    if (loginPressed) {
                      loginPressed = !loginPressed;
                      trans = -0.42;
                      loginAlignment = -0.53;
                      setState(() {});
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 180),
                    padding: EdgeInsets.symmetric(
                        horizontal: loginPressed ? 0 : 25,
                        vertical: loginPressed ? 0 : 9),
                    decoration: BoxDecoration(
                        color: loginPressed ? null : kprimary2,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "SIGNUP",
                      style: TextStyle(
                          color:
                              loginPressed ? kprimary : kwhite.withOpacity(0.9),
                          fontSize: response.setFontSize(13),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              AnimatedAlign(
                  duration: Duration(milliseconds: 190),
                  alignment: Alignment(-0.44, !loginPressed ? -0.15 : trans),
                  child: Image.asset(
                    'assets/images/boy.png',
                    height: 70,
                  )),
              AnimatedAlign(
                  duration: Duration(milliseconds: 190),
                  alignment: Alignment(0.44, loginPressed ? -0.15 : trans),
                  child: Image.asset(
                    'assets/images/boy.png',
                    height: 70,
                  )),
              Align(
                alignment: Alignment(0, !loginPressed ? -0.13 : -0.2),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    width: response.screenWidth * 0.9,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildSearch(hint: 'username', icon: Icons.text_fields),
                        buildSearch(hint: 'password', icon: Icons.lock),
                        loginPressed
                            ? Container()
                            : buildSearch(hint: 'password', icon: Icons.lock),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.4),
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: kwhite,
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_forward_sharp,
                    color: kprimary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
