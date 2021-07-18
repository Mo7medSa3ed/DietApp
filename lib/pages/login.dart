import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/forgetPassword.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:response/response.dart';

class LoginScrean extends StatefulWidget {
  @override
  _LoginScreanState createState() => _LoginScreanState();
}

class _LoginScreanState extends State<LoginScrean>
    with TickerProviderStateMixin {
  AnimationController _controller, _controller2;
  Animation<Offset> _offsetFloat, _offsetFloat2;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  var username, mobile, pass, age, isMale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _offsetFloat = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(_controller);
    _offsetFloat2 = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
        .animate(_controller2);

    _controller2.addListener(() {
      setState(() {});
    });

    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;
    return SafeArea(
        child: Scaffold(
            body: ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: DelayedDisplay(
            fadeIn: true,
            fadingDuration: Duration(seconds: 2),
            child: Text(
              "Welcome !",
              style: TextStyle(
                  fontSize: response.setFontSize(30),
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(height: response.setHeight(40)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _controller.value == 0.0
                    ? buildFillElevatedButton(
                        elevation: 0.0,
                        txtcolor: kprimary,
                        bgcolor: kcolor1,
                        text: "LOGIN",
                        onpressed: () {
                          _controller.reset();
                          _controller2.reset();
                          _controller.forward();
                        })
                    : ScaleTransition(
                        scale: CurvedAnimation(
                            parent: _controller, curve: Curves.linear),
                        child: buildFillElevatedButton(
                            bgcolor:
                                _controller.value == 0.0 ? kcolor1 : kprimary2,
                            text: "LOGIN",
                            onpressed: () {
                              if (_controller.value == 0.0) {
                                _controller.reset();
                                _controller2.reset();
                                _controller.forward();
                              }
                            }),
                      ),
                SlideTransition(
                    position: _offsetFloat,
                    child: Opacity(
                      opacity: _controller.value,
                      child: SvgPicture.asset(
                        "assets/images/hold.svg",
                        height: _controller.value > 0 ? 50 : 0,
                      ),
                    ))
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _controller2.value == 0.0
                    ? buildFillElevatedButton(
                        elevation: 0.0,
                        text: "SIGNUP",
                        txtcolor: kprimary,
                        bgcolor:
                            _controller2.value == 0.0 ? kcolor1 : kprimary2,
                        onpressed: () {
                          _controller2.reset();
                          _controller.reset();
                          _controller2.forward();
                        })
                    : ScaleTransition(
                        scale: CurvedAnimation(
                            parent: _controller2, curve: Curves.linear),
                        child: buildFillElevatedButton(
                            text: "SIGNUP",
                            bgcolor:
                                _controller2.value == 0.0 ? kcolor1 : kprimary2,
                            onpressed: () {
                              if (_controller2.value == 0.0) {
                                _controller2.reset();
                                _controller.reset();
                                _controller2.forward();
                              }
                            })),
                SlideTransition(
                    position: _offsetFloat2,
                    child: Opacity(
                      opacity: _controller2.value,
                      child: SvgPicture.asset(
                        "assets/images/hold.svg",
                        height: _controller2.value > 0 ? 50 : 0,
                      ),
                    ))
              ],
            )
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: response.screenWidth * 0.9,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Form(
                  key: _controller.value > 0.0 ? formKey : formKey2,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _controller.value > 0.0
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
                                    } else if (v.trim().isEmpty || v == null) {
                                      return 'please enter your age...';
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
                                      print(v);
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                elevation: 8,
                backgroundColor: kwhite,
                onPressed: () async {
                  if (_controller.value > 0.0) {
                    if (formKey.currentState.validate()) {
                      await login();
                    }
                  } else {
                    if (formKey2.currentState.validate()) {
                      await signUp();
                    }
                  }
                },
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: kprimary,
                ),
              ),
            ),
          ],
        ),
      ],
    )));
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
      await setValue(key: 'user', value: json.encode(resBody['data']));
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
          key: 'token', value: json.encode(resBody['data']['access_token']));
      await setValue(key: 'user', value: json.encode(resBody['data']['user']));

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
