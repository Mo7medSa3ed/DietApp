import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:response/response.dart';

class ForgetPasswordScrean extends StatefulWidget {
  final code;
  ForgetPasswordScrean({this.code});
  @override
  _ForgetPasswordScreanState createState() => _ForgetPasswordScreanState();
}

class _ForgetPasswordScreanState extends State<ForgetPasswordScrean> {
  final formKey = GlobalKey<FormState>();

  var pass, mobile, confirmPass;

  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16.0, vertical: response.setHeight(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DelayedDisplay(
                fadeIn: true,
                fadingDuration: Duration(milliseconds: 600),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "Forget Password",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: kprimary,
                        fontSize: response.setFontSize(28),
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: response.screenWidth * 0.9,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Form(
                          key: formKey,
                          child: DelayedDisplay(
                            fadeIn: true,
                            fadingDuration: Duration(milliseconds: 600),
                            child: Column(children: [
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
                              ...widget.code != null
                                  ? [
                                      // buildSearch(
                                      //     label: code,
                                      //     enabled: false,
                                      //     icon: null),
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
                                          label: 'Confirm Password',
                                          hint: 'enter your password again',
                                          autoValidate: true,
                                          onChange: (String value) {
                                            if (value.trim().isNotEmpty ||
                                                value != null) {
                                              setState(() {
                                                confirmPass = value.trim();
                                              });
                                            }
                                          },
                                          onValidate: (String v) {
                                            if (v.trim().isNotEmpty ||
                                                v != null) {
                                              if (v.trim() != pass)
                                                return 'password must be same...';
                                            }
                                          },
                                          icon: (pass == confirmPass) &&
                                                  (pass != null)
                                              ? Icons.verified
                                              : Icons.lock),
                                    ]
                                  : []
                            ]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              buildFillElevatedButton(
                onpressed: () async {
                  if (formKey.currentState.validate()) {
                    if (widget.code == null) {
                      await forgetPass();
                    } else {
                      await resetPass();
                    }
                  }
                },
                text: widget.code == null ? "Get Code" : "Confirm Password",
              )
            ],
          ),
        ),
      ),
    );
  }

  forgetPass() async {
    Alert.loadingAlert(ctx: context);
    final res = await API.forgetPassword(mobile);
    final resBody = json.decode(res.body);
    Navigator.of(context).pop();
    if (res.statusCode == 200 && resBody['success']) {
      goToWithReplace(
          context, ForgetPasswordScrean(code: resBody['data']['code']));
    } else if (res.statusCode != 200 || !resBody['success']) {
      return Alert.errorAlert(ctx: context, title: resBody['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: "tr('error404')");
    }
  }

  resetPass() async {
    Alert.loadingAlert(ctx: context);
    final body = {
      "mobile": mobile,
      "password": pass,
      "password_confirmation": confirmPass,
      "code": widget.code
    };
    final res = await API.resetPassword(body);
    final resBody = json.decode(res.body);
    Navigator.of(context).pop();
    if (res.statusCode == 200 && resBody['success']) {
      goToWithRemoveUntill(context, HomeScrean());
    } else if (res.statusCode != 200 || !resBody['success']) {
      return Alert.errorAlert(ctx: context, title: resBody['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: "tr('error404')");
    }
  }
}
