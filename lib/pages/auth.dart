import 'dart:convert';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/forgetPassword.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:response/response.dart';

class AuthScrean extends StatefulWidget {
  @override
  _AuthScreanState createState() => _AuthScreanState();
}

class _AuthScreanState extends State<AuthScrean> {
  bool loginPressed = true;
  double loginAlignment = -0.61;
  double trans = -0.5;
  final formKey = GlobalKey<FormState>();

  var username, mobile, pass, age, isMale;

  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
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
              alignment: Alignment(-0.5, loginPressed ? loginAlignment : -0.6),
              child: GestureDetector(
                onTap: () {
                  if (!loginPressed) {
                    loginPressed = !loginPressed;
                    trans = -0.5;
                    loginAlignment = -0.61;
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
              alignment: Alignment(0.5, loginPressed ? -0.6 : loginAlignment),
              child: GestureDetector(
                onTap: () {
                  if (loginPressed) {
                    loginPressed = !loginPressed;
                    trans = -0.52;
                    loginAlignment = -0.61;
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
                        fontSize: response.setFontSize(10),
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
              alignment: Alignment(0, !loginPressed ? 0.23 : -0.2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      width: response.screenWidth * 0.9,
                      padding: EdgeInsets.all(8),
                      child: Form(
                        key: formKey,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: loginPressed
                                ? [
                                    buildSearch(
                                        label: 'Mobile',
                                        hint: 'ex: 01234567890',
                                        icon: Icons.phone_android,
                                        maxlength: 11,
                                        onChange: (String value) {
                                          if (value.trim().isNotEmpty ||
                                              value != null) {
                                            setState(() {
                                              mobile = value.trim();
                                            });
                                          }
                                        },
                                        onValidate: (String v) {
                                          if (v.trim().isEmpty || v == null) {
                                            return 'please enter your mobile...';
                                          }
                                        }),
                                    buildSearch(
                                        label: 'Password',
                                        hint: 'enter your password',
                                        onChange: (String value) {
                                          if (value.trim().isNotEmpty ||
                                              value != null) {
                                            setState(() {
                                              pass = value.trim();
                                            });
                                          }
                                        },
                                        onValidate: (String v) {
                                          if (v.trim().isEmpty || v == null) {
                                            return 'please enter your password...';
                                          }
                                        },
                                        icon: Icons.lock),
                                  ]
                                : [
                                    buildSearch(
                                        label: 'Username',
                                        hint: 'enter your name',
                                        onChange: (String value) {
                                          if (value.trim().isNotEmpty ||
                                              value != null) {
                                            setState(() {
                                              username = value.trim();
                                            });
                                          }
                                        },
                                        onValidate: (String v) {
                                          if (v.trim().isEmpty || v == null) {
                                            return 'please enter your name...';
                                          }
                                        },
                                        icon: Icons.person),
                                    buildSearch(
                                      label: 'Mobile',
                                      hint: 'ex: 01234567890',
                                      icon: Icons.phone_android,
                                      keyboard: TextInputType.phone,
                                      maxlength: 11,
                                      onChange: (String value) {
                                        if (value.trim().isNotEmpty ||
                                            value != null) {
                                          setState(() {
                                            mobile = value.trim();
                                          });
                                        }
                                      },
                                      onValidate: (String v) {
                                        if (v.trim().isEmpty || v == null) {
                                          return 'please enter your mobile...';
                                        }
                                      },
                                    ),
                                    buildSearch(
                                        label: 'Password',
                                        hint: 'enter your password',
                                        onChange: (String value) {
                                          if (value.trim().isNotEmpty ||
                                              value != null) {
                                            setState(() {
                                              pass = value.trim();
                                            });
                                          }
                                        },
                                        onValidate: (String v) {
                                          if (v.trim().isEmpty || v == null) {
                                            return 'please enter your password...';
                                          }
                                        },
                                        icon: Icons.lock),
                                    buildSearch(
                                        label: "Age",
                                        hint: 'enter your age',
                                        icon: null,
                                        autoValidate: true,
                                        maxlength: 2,
                                        onChange: (String value) {
                                          if (value.trim().isNotEmpty ||
                                              value != null) {
                                            setState(() {
                                              age = value.trim();
                                            });
                                          }
                                        },
                                        onValidate: (String v) {
                                          if (v != null && v.isNotEmpty) {
                                            if (int.parse(v.trim()) < 6) {
                                              return "age must be greater than 6";
                                            }
                                          }
                                        },
                                        keyboard: TextInputType.number),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: RadioListTile(
                                          activeColor: kprimary,
                                          groupValue: isMale,
                                          value: 'male',
                                          onChanged: (v) {
                                          
                                            isMale = v;
                                            setState(() {});
                                          },
                                          title: Text("Male"),
                                        )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: RadioListTile(
                                          activeColor: kprimary,
                                          groupValue: isMale,
                                          value: 'female',
                                          onChanged: (v) {
                                            isMale = v;
                                            setState(() {});
                                          },
                                          title: Text("Female"),
                                        ))
                                      ],
                                    )
                                  ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => goTo(context, ForgetPasswordScrean()),
                          child: Text(
                            "Forget password ?",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: kprimary,
                                fontSize: response.setFontSize(13),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0.0, loginPressed ? 0.6 : 0.8),
              child: FloatingActionButton(
                elevation: 8,
                backgroundColor: kwhite,
                onPressed: () async {
                   if (formKey.currentState.validate()) {
                    if (loginPressed) {
                      await login();
                    } else {
                      await signUp();
                    }
                  }
          
                },
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: kprimary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  signUp() async {
    Alert.loadingAlert(ctx: context);
    final body = {
      "name": username,
      "mobile": mobile,
      "password": pass,
      "gender": isMale,
      "age": age,
    };

    final res = await API.signupUser(body);
    final resBody = json.decode(res.body);
    Navigator.of(context).pop();
    if (res.statusCode == 200 && resBody['success']) {
      await setValue(key: 'user', value: jsonEncode(resBody['data']));
      return Alert.sucessAlert(
          ctx: context,
          text: "User Registered Successfully",
          title: "Sing Up",
          ontap: () => goToWithRemoveUntill(context, HomeScrean()));
    } else if (res.statusCode != 200 || !resBody['success']) {
      return Alert.errorAlert(ctx: context, title: resBody['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: "Something went wrong...");
    }
  }

  login() async {
    Alert.loadingAlert(ctx: context);
    final body = {"mobile": mobile, "password": pass};

    final res = await API.loginUser(body);
    final resBody = json.decode(res.body);
    Navigator.of(context).pop();
    if (res.statusCode == 200 && resBody['success']) {
      await setValue(
          key: 'token', value: jsonEncode(resBody['data']['access_token']));
      await setValue(key: 'user', value: jsonEncode(resBody['data']['user']));

      return Alert.sucessAlert(
          ctx: context,
          text: "User Login Successfully",
          title: "Login",
          ontap: () => goToWithRemoveUntill(context, HomeScrean()));
    } else if (res.statusCode != 200 || !resBody['success']) {
      return Alert.errorAlert(ctx: context, title: resBody['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: "Something went wrong...");
    }
  }
}
