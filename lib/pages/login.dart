import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/height.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
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
  var phoneController = TextEditingController(text: '');
  var genderController = TextEditingController(text: tr('male'));
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
        ),
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: DelayedDisplay(
              fadeIn: true,
              fadingDuration: Duration(seconds: 2),
              child: Text(
                tr('welcome'),
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
                          txtcolor: ksecondary,
                          bgcolor: kwhite.withOpacity(0.5),
                          text: tr('login'),
                          onpressed: () {
                            _controller.reset();
                            _controller2.reset();
                            _controller.forward();
                          })
                      : ScaleTransition(
                          scale: CurvedAnimation(
                              parent: _controller, curve: Curves.linear),
                          child: buildFillElevatedButton(
                              bgcolor: _controller.value == 0.0
                                  ? kcolor1
                                  : kprimary2,
                              text: tr('login'),
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
                          text: tr('sign_up'),
                          txtcolor: ksecondary,
                          bgcolor: kwhite.withOpacity(0.5),
                          onpressed: () {
                            _controller2.reset();
                            _controller.reset();
                            _controller2.forward();
                          })
                      : ScaleTransition(
                          scale: CurvedAnimation(
                              parent: _controller2, curve: Curves.linear),
                          child: buildFillElevatedButton(
                              text: tr('sign_up'),
                              bgcolor: _controller2.value == 0.0
                                  ? kcolor1
                                  : kprimary2,
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
              Container(
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
                                  text: tr('phone'),
                                  hint: tr('hint_msg',
                                      namedArgs: {'attribute': tr('phone')}),
                                  controller: phoneController),
                              buldinputContainer(
                                text: tr('password'),
                                controller: passController,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TextFormField(
                                    controller: passController,
                                    validator: (String v) {
                                      if (v.trim().isEmpty || v == null) {
                                        return tr('validate_msg', namedArgs: {
                                          'attribute': tr('password')
                                        });
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
                                        hintText: tr('hint_msg', namedArgs: {
                                          'attribute': tr('password')
                                        })),
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
                                  text: tr('name'),
                                  hint: tr('hint_msg',
                                      namedArgs: {'attribute': tr('name')}),
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
                                    if (v.length <= 11) setState(() {});
                                  },
                                  text: tr('phone'),
                                  hint: tr('hint_msg',
                                      namedArgs: {'attribute': tr('phone')}),
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
                                  text: tr('location'),
                                  validator: (v) {
                                    return null;
                                  },
                                  hint: tr('hint_msg',
                                      namedArgs: {'attribute': tr('location')}),
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
                                  text: tr('birthdate'),
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
                                                : tr('hint_msg', namedArgs: {
                                                    'attribute': tr('birthdate')
                                                  }),
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
                                text: tr('gender'),
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
                                      items: [tr('male'), tr('female')],
                                      popupBackgroundColor: kcolor1,
                                      maxHeight: 100,
                                      hint: tr('hint_msg', namedArgs: {
                                        'attribute': tr('gender')
                                      }),
                                      onChanged: (v) {
                                        genderController.text = v;
                                      },
                                      selectedItem: tr('male')),
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
                                text: tr('password'),
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
                                        return tr('hint_msg', namedArgs: {
                                          'attribute': tr('password')
                                        });
                                      }
                                      if (v.trim().length < 6) {
                                        return tr('max_validate_msg',
                                            namedArgs: {
                                              'attribute': tr('password'),
                                              'num': '6'
                                            });
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
                                        hintText: tr('hint_msg', namedArgs: {
                                          'attribute': tr('password')
                                        })),
                                  ),
                                ),
                              ),
                              buldinputContainer(
                                text: tr('confirm_pass'),
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
                                        return tr('hint_msg', namedArgs: {
                                          'attribute': tr('confirm_pass')
                                        });
                                      }
                                      if (v.trim() != passController.text) {
                                        return tr('same_validate_msg',
                                            namedArgs: {
                                              'attribute': tr('password')
                                            });
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
                                        hintText: tr('hint_msg', namedArgs: {
                                          'attribute': tr('confirm_pass')
                                        })),
                                  ),
                                ),
                              )
                            ]),
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
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                        backgroundColor: MaterialStateProperty.all(kwhite),
                        overlayColor: MaterialStateProperty.all(
                            kprimary2.withOpacity(0.2)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
                        shadowColor: MaterialStateProperty.all(
                            kprimary2.withOpacity(0.5)),
                        elevation: MaterialStateProperty.all(10)),
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
                      context.locale == Locale('ar')
                          ? Icons.arrow_back_sharp
                          : Icons.arrow_forward_sharp,
                      color: kprimary,
                      size: 30,
                    ),
                  )

                  //  FloatingActionButton(
                  //   heroTag: "btn4",
                  //   elevation: 8,
                  //   splashColor: kprimary2,
                  //   backgroundColor: kwhite,
                  //   onPressed: () async {
                  //     if (_controller.value > 0.0) {
                  //       if (formKey.currentState.validate()) {
                  //         await login();
                  //       }
                  //     } else {
                  //       if (formKey2.currentState.validate()) {
                  //         await signUp();
                  //       }
                  //     }
                  //     //goTo(context, HomeScrean());
                  //   },
                  //   child: Icon(
                  //     context.locale == Locale('ar')
                  //         ? Icons.arrow_back_sharp
                  //         : Icons.arrow_forward_sharp,
                  //     color: kprimary,
                  //   ),
                  // ),
                  ),
            ],
          ),
        ],
      ),
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
      "birth_date": selectedDate.toString().substring(0, 10),
      "location": locationController.text,
    };

    final res = await API.signupUser(body);
    Navigator.of(context).pop();
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    final resBody = json.decode(res.body);

    if ((res.statusCode == 200 || res.statusCode == 201) &&
        resBody['success']) {
      await setValue(key: 'user', value: json.encode(resBody['data']));
      Provider.of<AppProvider>(context, listen: false)
          .initUser(resBody['data']);
      return Alert.sucessAlert(
          ctx: context,
          text: tr('success', namedArgs: {'attribute': tr('signup')}),
          title: tr('sign_up_full').toLowerCase(),
          ontap: () => goToWithRemoveUntill(context, LoginScrean()));
    } else if (res.statusCode != 200 || !resBody['success']) {
      return Alert.errorAlert(ctx: context, title: resBody['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: tr('error404'));
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
    if (res == 'error')
      return Alert.errorAlert(ctx: context, title: tr('error404'));

    if (res.statusCode == 200 && resBody['success']) {
      await setValue(
          key: 'token', value: json.encode(resBody['data']['access_token']));
      await setValue(key: 'user', value: json.encode(resBody['data']['user']));
      Provider.of<AppProvider>(context, listen: false)
          .initUser(resBody['data']['user']);
      return Alert.sucessAlert(
          ctx: context,
          text: tr('success', namedArgs: {'attribute': tr('login')}),
          title: tr('login_full').toLowerCase(),
          ontap: () => goToWithRemoveUntill(
              context,
              (resBody['data']['user']['height'] != null &&
                      resBody['data']['user']['weight'] != null)
                  ? HomeScrean()
                  : HeightScrean()));
    } else if (res.statusCode != 200 || !resBody['success']) {
      return Alert.errorAlert(ctx: context, title: tr('phone_pass_error'));
    } else {
      return Alert.errorAlert(ctx: context, title: tr('error404'));
    }
  }
}
