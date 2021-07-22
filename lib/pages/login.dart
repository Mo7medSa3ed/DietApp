import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/height.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
  bool isLoading = false;
  bool isVisible = true;
  var nameController = TextEditingController(text: '');
  //var ageController = TextEditingController(text: '');
  //var emailController = TextEditingController(text: '');
  var phoneController = TextEditingController(text: '');
  var genderController = TextEditingController(text: 'Male');
  var locationController = TextEditingController(text: '');
  var passController = TextEditingController(text: '');
  var confirController = TextEditingController(text: '');
  bool isEgypt = true;
  bool isConfirmVisible = true;
  var selectedDate;
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
                 physics: BouncingScrollPhysics(),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          child: DelayedDisplay(
            fadeIn: true,
            fadingDuration: Duration(seconds: 2),
            child: Text(
              "Welcome !",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: response.setFontSize(35),
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
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
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Form(
                  key: _controller.value > 0.0 ? formKey : formKey2,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _controller.value > 0.0
                          ? [
                              // buldinputContainer(
                              //     onChange: (v) {
                              //       if (v.length == 0 || v.length == 1)
                              //         setState(() {});
                              //     },
                              //     text: "Email",
                              //     hint: 'Enter your email ...',
                              //     controller: emailController),
                              buldinputContainer(
                                  onChange: (v) {
                                    if (v.length == 0 || v.length == 1)
                                      setState(() {});
                                  },
                                  text: "Phone",
                                  hint: 'enter mobile phone ...',
                                  controller: phoneController),
                              buldinputContainer(
                                text: "Password",
                                controller: passController,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TextFormField(
                                    controller: passController,
                                    validator: (String v) {
                                      if (v.trim().isEmpty || v == null) {
                                        return 'please enter your password...';
                                      }
                                      return null;
                                    },
                                    onChanged: (v) {
                                      setState(() {});
                                    },
                                    obscureText: isVisible,
                                    cursorColor: kprimary,
                                    style: TextStyle(
                                        color: kprimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              isVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: ksecondary,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isVisible = !isVisible;
                                              });
                                            }),
                                        hintStyle: TextStyle(
                                            color: ksecondary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                        border: InputBorder.none,
                                        hintText: "enter your password ..."),
                                  ),
                                ),
                              ),
                            ]
                          : [
                              buldinputContainer(
                                  onChange: (v) {
                                    if (v.length == 0 || v.length == 1)
                                      setState(() {});
                                  },
                                  text: "Name",
                                  hint: 'enter client name ...',
                                  controller: nameController),
                              // buldinputContainer(
                              //     onChange: (v) {
                              //       if (v.length == 0 || v.length == 1)
                              //         setState(() {});
                              //     },
                              //     text: "Email",
                              //     hint: 'Enter your email ...',
                              //     controller: emailController),
                              buldinputContainer(
                                  onChange: (v) {
                                    if (v.length == 0 || v.length == 1)
                                      setState(() {});
                                  },
                                  text: "Phone",
                                  hint: 'enter mobile phone ...',
                                  controller: phoneController),
                              /*   Row(
                children: [
                  Spacer(),
                  Container(
                    margin:EdgeInsets.symmetric(horizontal: 20),
                    width: 200,
                    child: buildFillElevatedButton(
                      text: "Send Code",
                      onpressed: () {},
                    ),
                  ),
                ],
              ),
              buldinputContainer(
                  text: "Confirmation Code",
                  hint: 'Enter confirmation code ...',
                  controller: TextEditingController(text: '')), */
                              buldinputContainer(
                                  onChange: (v) {
                                    if (v.length == 0 || v.length == 1)
                                      setState(() {});
                                  },
                                  hint: "enter your location ...",
                                  text: "Location",
                                  isLoading: isLoading,
                                  onpressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    final add = await getCurrantaddress();
                                    locationController.text = add.addressLine;

                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  controller: locationController),
                              buldinputContainer(
                                  text: "Birth date",
                                  widget: InkWell(
                                      onTap: () async {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        selectedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime(2000),
                                            firstDate: DateTime(1970),
                                            lastDate: DateTime.now());
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 16),
                                        child: Text(
                                            selectedDate != null
                                                ? DateFormat('dd/MM/yyyy')
                                                    .format(selectedDate)
                                                    .toString()
                                                : 'select your birthdate',
                                            style: TextStyle(
                                                color: selectedDate != null
                                                    ? kprimary
                                                    : ksecondary,
                                                fontWeight: selectedDate != null
                                                    ? FontWeight.w900
                                                    : FontWeight.w600,
                                                fontSize: selectedDate != null
                                                    ? 18
                                                    : 16)),
                                      )),
                                  controller: TextEditingController(text: '')),
                              buldinputContainer(
                                text: "Gender",
                                controller: genderController,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: DropdownSearch<String>(
                                      searchBoxDecoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      dropdownSearchDecoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      mode: Mode.MENU,
                                      dropdownBuilder: (context, selectedItem,
                                              itemAsString) =>
                                          Text(
                                            selectedItem,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18),
                                          ),
                                      items: ['Male', 'Female'],
                                      popupBackgroundColor: kcolor1,
                                      maxHeight: 100,
                                      hint: "choose your gender ...",
                                      onChanged: (v) {
                                        genderController.text = v;
                                      },
                                      selectedItem: "Male"),
                                ),
                              ),
                              // buldinputContainer(
                              //     onChange: (v) {
                              //       if (v.length == 0 || v.length == 1)
                              //         setState(() {});
                              //     },
                              //     text: "Age",
                              //     hint: "enter your age ...",
                              //     controller: ageController),
                              buldinputContainer(
                                text: "Password",
                                controller: passController,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: passController,
                                    onChanged: (v) {
                                      setState(() {});
                                    },
                                    validator: (String v) {
                                      if (v.trim().isEmpty || v == null) {
                                        return 'please enter your password...';
                                      }
                                      if (v.trim().length < 6) {
                                        return 'password must be at least 6 character !!';
                                      }
                                      return null;
                                    },
                                    obscureText: isVisible,
                                    cursorColor: kprimary,
                                    style: TextStyle(
                                        color: kprimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              isVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: ksecondary,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isVisible = !isVisible;
                                              });
                                            }),
                                        hintStyle: TextStyle(
                                            color: ksecondary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                        border: InputBorder.none,
                                        hintText: "enter your password ..."),
                                  ),
                                ),
                              ),
                              buldinputContainer(
                                text: "Confirm Password",
                                controller: confirController,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (v) {
                                      if (v.length == 0 || v.length == 1)
                                        setState(() {});
                                    },
                                    validator: (String v) {
                                      if (v.trim().isEmpty || v == null) {
                                        return 'please enter your Confirm password...';
                                      }
                                      if (v.trim() != passController.text) {
                                        return 'confirm password not a same !!';
                                      }
                                      return null;
                                    },
                                    controller: confirController,
                                    obscureText: isConfirmVisible,
                                    cursorColor: kprimary,
                                    style: TextStyle(
                                        color: kprimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              isConfirmVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: ksecondary,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isConfirmVisible =
                                                    !isConfirmVisible;
                                              });
                                            }),
                                        hintStyle: TextStyle(
                                            color: ksecondary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                        border: InputBorder.none,
                                        hintText:
                                            "enter confirm password ...."),
                                  ),
                                ),
                              )
                            ]),
                ),
              ),
            ),
            // Container(
            //   width: response.screenWidth * 0.9,
            //   padding: const EdgeInsets.symmetric(vertical: 16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       InkWell(
            //         onTap: () => goTo(context, ForgetPasswordScrean()),
            //         child: Text(
            //           "Forget password ?",
            //           textAlign: TextAlign.end,
            //           style: TextStyle(
            //               color: kprimary,
            //               fontSize: response.setFontSize(13),
            //               fontWeight: FontWeight.w700),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                heroTag: "btn4",
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
                  //goTo(context, HomeScrean());
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
    if (confirController.text.trim() != passController.text.trim()) return;
    Alert.loadingAlert(ctx: context);
    final body = {
      "name": nameController.text,
      "mobile": "+2" + phoneController.text,
      "password": passController.text,
      "gender": genderController.text.toLowerCase(),
      "birth_date": selectedDate.toString(),
      "location": locationController.text,
    };

    final res = await API.signupUser(body);
    Navigator.of(context).pop(); 
    if (res == 'error')
      return Alert.errorAlert(
          ctx: context,
          title:
              errorMsg);
    final resBody = json.decode(res.body);
 

    if ((res.statusCode == 200 || res.statusCode == 201) &&
        resBody['success']) {
      await setValue(key: 'user', value: json.encode(resBody['data']));
      Provider.of<AppProvider>(context, listen: false)
          .initUser(resBody['data']);
      return Alert.sucessAlert(
          ctx: context,
          text: 'User Registered Successfully \nyou must login agin!',
          title: "Sing Up",
          ontap: () => goToWithRemoveUntill(context, LoginScrean()));
    } else if (res.statusCode != 200 || !resBody['success']) {
      return Alert.errorAlert(ctx: context, title: resBody['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: "Something went wrong...");
    }
  }

  login() async {
    Alert.loadingAlert(ctx: context);
    final body = {
      "mobile": "+2" + phoneController.text,
      "password": passController.text
    };

    final res = await API.loginUser(body);
    final resBody = json.decode(res.body);
    Navigator.of(context).pop();
    if (res.statusCode == 200 && resBody['success']) {
      await setValue(
          key: 'token', value: json.encode(resBody['data']['access_token']));
      await setValue(key: 'user', value: json.encode(resBody['data']['user']));
      Provider.of<AppProvider>(context, listen: false)
          .initUser(resBody['data']['user']);
      return Alert.sucessAlert(
          ctx: context,
          text: "User Login Successfully",
          title: "Login",
          ontap: () => goToWithRemoveUntill(
              context,
              (resBody['data']['user']['height'] != null &&
                      resBody['data']['user']['weight'] != null)
                  ? HomeScrean()
                  : HeightScrean()));
    } else if (res.statusCode != 200 || !resBody['success']) {
      return Alert.errorAlert(ctx: context, title: resBody['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: "Something went wrong...");
    }
  }
}
