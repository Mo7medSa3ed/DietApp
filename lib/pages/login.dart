import 'package:delayed_display/delayed_display.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/forgetPassword.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:intl/intl.dart';
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

  bool isVisible = true;
  var nameController = TextEditingController(text: '');
  var emailController = TextEditingController(text: '');
  var phoneController = TextEditingController(text: '');
  var locationController = TextEditingController(text: '');
  var passController = TextEditingController(text: '');
  var confirController = TextEditingController(text: '');

  bool isConfirmVisible = true;
  var _selectedDate;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final response = ResponseUI.instance;
    print(_controller2.value);
    return SafeArea(
        child: Scaffold(
            body: ListView(
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
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Form(
                  key: _controller.value > 0.0 ? formKey : formKey2,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _controller.value > 0.0
                          ? [
                              buldinputContainer(
                                  onChange: (v) {
                                    if (v.length == 0 || v.length == 1)
                                      setState(() {});
                                  },
                                  text: "Email",
                                  hint: 'Enter your email ...',
                                  controller: emailController),
                              buldinputContainer(
                                text: "Password",
                                controller: passController,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextField(
                                    controller: passController,
                                    onChanged: (v) {
                                      setState(() {});
                                    },
                                    obscureText: isVisible,
                                    cursorColor: kprimary,
                                    style: TextStyle(
                                        color: kprimary,
                                        fontSize: 20,
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
                                            fontSize: 18,
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
                                  hint: 'Enter client name ...',
                                  controller: nameController),
                              buldinputContainer(
                                  onChange: (v) {
                                    if (v.length == 0 || v.length == 1)
                                      setState(() {});
                                  },
                                  text: "Email",
                                  hint: 'Enter your email ...',
                                  controller: emailController),
                              buldinputContainer(
                                  onChange: (v) {
                                    if (v.length == 0 || v.length == 1)
                                      setState(() {});
                                  },
                                  text: "Phone Number",
                                  widget: "phone",
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
                                  hint: "Enter your location ...",
                                  text: "Location",
                                  onpressed: () async {
                                    await getCurrantLocation(context);
                                  },
                                  controller: locationController),
                              buldinputContainer(
                                  text: "Birth date",
                                  widget: InkWell(
                                      onTap: () async {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        _selectedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime(2000),
                                            firstDate: DateTime(1970),
                                            lastDate: DateTime.now());
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 16),
                                        child: Text(
                                            _selectedDate != null
                                                ? DateFormat('dd/MM/yyyy')
                                                    .format(_selectedDate)
                                                    .toString()
                                                : 'select your birthdate',
                                            style: TextStyle(
                                                color: _selectedDate != null
                                                    ? kprimary
                                                    : ksecondary,
                                                fontWeight:
                                                    _selectedDate != null
                                                        ? FontWeight.w900
                                                        : FontWeight.w600,
                                                fontSize: _selectedDate != null
                                                    ? 20
                                                    : 18)),
                                      )),
                                  controller: TextEditingController(text: '')),
                              buldinputContainer(
                                text: "Gender",
                                controller: TextEditingController(text: ''),
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                                fontSize: 20),
                                          ),
                                      items: ['Male', 'Female'],
                                      popupBackgroundColor: kcolor1,
                                      maxHeight: 110,
                                      hint: "Choose your gender ...",
                                      onChanged: print,
                                      selectedItem: "Male"),
                                ),
                              ),
                              buldinputContainer(
                                text: "Password",
                                controller: passController,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextField(
                                    controller: passController,
                                    onChanged: (v) {
                                      setState(() {});
                                    },
                                    obscureText: isVisible,
                                    cursorColor: kprimary,
                                    style: TextStyle(
                                        color: kprimary,
                                        fontSize: 20,
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
                                            fontSize: 18,
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
                                      horizontal: 20.0),
                                  child: TextField(
                                    onChanged: (v) {
                                      if (v.length == 0 || v.length == 1)
                                        setState(() {});
                                    },
                                    controller: confirController,
                                    obscureText: isConfirmVisible,
                                    cursorColor: kprimary,
                                    style: TextStyle(
                                        color: kprimary,
                                        fontSize: 20,
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
                                            fontSize: 18,
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
            Container(
              width: response.screenWidth * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                  /* if (_controller.value > 0.0) {
                    if (formKey.currentState.validate()) {
                      await login();
                    }
                  } else {
                    if (formKey2.currentState.validate()) {
                      await signUp();
                    }
                  } */
                  goTo(context, HomeScrean());
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
/* 
  signUp() async {
    Alert.loadingAlert(ctx: context);
    final body = {
      "name": nameController.text,
      "mobile": ,
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
 */
}
