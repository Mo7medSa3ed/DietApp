import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/acheive.dart';
import 'package:flutter_test_app/pages/cart.dart';
import 'package:flutter_test_app/pages/course.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/pages/orders.dart';
import 'package:flutter_test_app/pages/profile.dart';
import 'package:flutter_test_app/pages/shop.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';
import 'package:toast/toast.dart';

final response = ResponseUI.instance;

buildFillElevatedButton({text, onpressed, bgcolor = kprimary2, txtcolor}) {
  return ElevatedButton(
    onPressed: onpressed,
    child: Text(text.toString().trim(),
        style: TextStyle(
            color: txtcolor ?? kwhite.withOpacity(0.9),
            fontWeight: FontWeight.w900,
            fontSize: response.setFontSize(16))),
    style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
        backgroundColor: MaterialStateProperty.all<Color>(bgcolor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ))),
  );
}

buildIconButton({icon, onpressed}) {
  return InkWell(
    splashColor: kprimary,
    onTap: onpressed,
    child: Container(
      width: 35,
      height: 30,
      decoration: BoxDecoration(
          color: kprimary2, borderRadius: BorderRadius.circular(15)),
      child: Icon(
        icon,
        size: 20,
        color: kwhite,
      ),
    ),
  );
}

buildOutElevatedButton({text, onpressed, test: true}) {
  return ElevatedButton(
    onPressed: onpressed,
    child: Text(
      text.toString().trim(),
      style: TextStyle(
          color: test ? ksecondary : kprimary2,
          fontSize: response.setFontSize(16),
          fontWeight: FontWeight.w900),
    ),
    style: ButtonStyle(
        elevation: !test ? MaterialStateProperty.all(0) : null,
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
        backgroundColor: MaterialStateProperty.all<Color>(kwhite),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          side: test
              ? BorderSide(
                  color: kprimary.withOpacity(0.6),
                  width: 2,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ))),
  );
}

buildIconElevatedButton(
    {icon, label, onpressed, color = kwhite, bg = kprimary2}) {
  return ElevatedButton.icon(
    label: Text(label,
        style: TextStyle(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        )),
    onPressed: onpressed,
    icon: icon,
    style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18)),
        backgroundColor: MaterialStateProperty.all<Color>(bg),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ))),
  );
}

buildIconElevatedButtonOutLine(
    {icon, label, onpressed, color = kprimary, fontSize = 16.0}) {
  return ElevatedButton.icon(
    label: Text(
      label,
      style: TextStyle(
          color: color,
          fontSize: response.setFontSize(fontSize),
          fontWeight: FontWeight.w900),
    ),
    onPressed: onpressed,
    icon: icon,
    style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
        backgroundColor: MaterialStateProperty.all<Color>(kwhite),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          side: BorderSide(
            color: kprimary.withOpacity(0.6),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ))),
  );
}

buildDialog({context, text, desc, img, test = true}) {
  return showDialog(
      context: context,
      builder: (ctx) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
              margin: EdgeInsets.all(20),
              height: response.screenHeight * 0.55,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: response.setHeight(160),
                    child:
                        FlutterLogo() /*  Image.asset("assets/images/$img") */,
                  ),
                  Text(text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: response.setFontSize(16)),
                      textAlign: TextAlign.center),
                  Text(desc,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: kprimary.withOpacity(0.3),
                          fontSize: response.setFontSize(12)),
                      textAlign: TextAlign.center),
                  buildOutElevatedButton(
                      text: "Continue Shopping", onpressed: () {}, test: test),
                  buildFillElevatedButton(
                      text: "Go To Orders", onpressed: () {}),
                ],
              ),
            ),
          ));
}

buildDialogforNotification(
    {context,
    text,
    desc,
    img,
    test = true,
    conTap,
    backTap,
    conText,
    backText}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
              margin: EdgeInsets.all(20),
              height: response.screenHeight * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: response.setHeight(160),
                    child: Image.asset("assets/images/$img"),
                  ),
                  Text(text,
                      style: TextStyle(
                          color: kprimary,
                          fontWeight: FontWeight.w900,
                          fontSize: response.setFontSize(18)),
                      textAlign: TextAlign.center),
                  Text(desc,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: ksecondary,
                          fontSize: response.setFontSize(14)),
                      textAlign: TextAlign.center),
                  buildFillElevatedButton(text: conText, onpressed: conTap),
                  buildOutElevatedButton(
                      text: backText, onpressed: backTap, test: test),
                ],
              ),
            ),
          ));
}

buildCartItem() {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: response.setHeight(100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: kwhite),
            child: Row(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //     fit: BoxFit.contain,
                      //     image: AssetImage("assets/images/image4.png")),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey[200]),
                  child: Image.asset(
                    "assets/images/image4.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: response.setWidth(10),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Continu Shopping",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              color: kprimary,
                              fontWeight: FontWeight.w900,
                              fontSize: response.setFontSize(16))),
                      SizedBox(
                        height: response.setHeight(4),
                      ),
                      Text(
                        "Continu Shoppingsadasdasdsa",
                        softWrap: false,
                        style: TextStyle(
                            color: ksecondary,
                            fontWeight: FontWeight.w900,
                            fontSize: response.setFontSize(13.0)),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: response.setHeight(4),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "\$ 55",
                                softWrap: false,
                                style: TextStyle(
                                    color: kprimary,
                                    fontWeight: FontWeight.w900,
                                    fontSize: response.setFontSize(16.5)),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    buildIconButton(
                                        icon: Icons.remove, onpressed: () {}),
                                    Text(
                                      "2",
                                      style: TextStyle(
                                          color: kprimary,
                                          fontWeight: FontWeight.w900,
                                          fontSize: response.setFontSize(14)),
                                    ),
                                    buildIconButton(
                                        icon: Icons.add, onpressed: () {}),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
            width: 50,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_forever,
                  color: kprimary,
                  size: 40,
                )))
      ],
    ),
  );
}

buildCourseItem() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          // height: response.setHeight(94),
          width: response.screenWidth - 32,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: kwhite),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 80,
                width: 80,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    /*   image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://digitaldefynd.com/wp-content/uploads/2020/04/Best-Food-Styling-course-tutorial-class-certification-training-online-1024x625.jpg",
                        )), */
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey[200]),
                child: Image.asset("assets/images/image4.png"),
              ),
              SizedBox(
                width: response.setWidth(10),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Forevver Therm",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: kprimary,
                          fontWeight: FontWeight.w900,
                          fontSize: response.setFontSize(16.2))),
                  SizedBox(
                    height: response.setHeight(2),
                  ),
                  Text("Forevver Therm",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: ksecondary,
                          fontWeight: FontWeight.w900,
                          fontSize: response.setFontSize(14))),
                  SizedBox(
                    height: response.setHeight(2),
                  ),
                  Text("x 1",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: kprimary,
                          fontWeight: FontWeight.w900,
                          fontSize: response.setFontSize(16.5))),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

buildShopItem(context) {
  return Stack(
    children: [
      Container(
        height: response.setHeight(100),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: response.setHeight(96),
              width: response.screenWidth - 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: kwhite),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: kcolor1.withOpacity(0.5),
                    ),
                    child: Image.asset("assets/images/image4.png"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(
                            child: Text("Forevver Therm",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: kprimary,
                                    fontWeight: FontWeight.w900,
                                    fontSize: response.setFontSize(16))),
                          ),
                          buildText("\$ 55", color: kprimary2, fontsize: 22.0),
                          SizedBox(
                            width: 8,
                          )
                        ]),
                        SizedBox(
                          height: 2,
                        ),
                        Text("Forevver Therm",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: ksecondary,
                                fontWeight: FontWeight.w900,
                                fontSize: response.setFontSize(14))),
                        SizedBox(
                          height: 2,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildIconButton(
                                  icon: Icons.remove, onpressed: () {}),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                    color: kprimary,
                                    fontWeight: FontWeight.w900,
                                    fontSize: response.setFontSize(14)),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              buildIconButton(
                                  icon: Icons.add, onpressed: () {}),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        right: 35,
        bottom: 0,
        child: FloatingActionButton(
          backgroundColor: kdrawer,
          elevation: 1,
          onPressed: () {
            Toast.show("Product added to cart successfully", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          },
          child: Image.asset("assets/images/cart.png"),
        ),
      )
    ],
  );
}

buildText(text, {color = kprimary, fontsize}) {
  return Text(text.toString().trim(),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: fontsize != null ? fontsize : response.setFontSize(18)));
}

buildText2(text, {color = ksecondary, fontsize}) {
  return Text(text.toString().trim(),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: fontsize != null ? fontsize : response.setFontSize(16)));
}

buildOrderItem() {
  return Card(
    margin: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.grey[50]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: buildText2("Client Name : "),
                ),
                Expanded(
                  flex: 20,
                  child: buildText("Mohamed Saeed"),
                ),
              ],
            ),
            SizedBox(
              height: response.setHeight(8),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: buildText2("Address : "),
                ),
                Expanded(
                  flex: 20,
                  child: buildText("Minya Alqamh sharkia wagih abaza"),
                ),
              ],
            ),
            SizedBox(
              height: response.setHeight(8),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: buildText2("Phone : "),
                ),
                Expanded(
                  flex: 20,
                  child: buildText("+02 01017030127"),
                ),
              ],
            ),
            SizedBox(
              height: response.setHeight(8),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: buildText2("Order : "),
                ),
                Expanded(
                    flex: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          List.generate(10, (index) => buildText(" 2 x food ")),
                    )),
              ],
            ),
            SizedBox(
              height: response.setHeight(8),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: buildText2("Total Price : "),
                ),
                Expanded(
                  flex: 20,
                  child: buildText("50"),
                ),
              ],
            ),
            SizedBox(
              height: response.setHeight(8),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: buildText2("Date : "),
                ),
                Expanded(
                  flex: 20,
                  child: buildText("05/05/2021"),
                ),
              ],
            ),
            SizedBox(
              height: response.setHeight(8),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: buildText2("Status : "),
                ),
                Expanded(
                  flex: 20,
                  child: buildText2("pending.....  "),
                ),
              ],
            ),
            SizedBox(
              height: response.setHeight(15),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: buildIconElevatedButton(
                      label: ' Edit Order',
                      icon: Image.asset("assets/images/edit-button.png"),
                      onpressed: () {}),
                ),
                SizedBox(
                  width: response.setWidth(15),
                ),
                Expanded(
                  child: buildIconElevatedButtonOutLine(
                      label: '\tCancel',
                      color: kprimary2,
                      fontSize: 17.0,
                      icon: Icon(
                        Icons.close,
                        color: kprimary2,
                        size: 25,
                      ),
                      onpressed: () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

buildAppBar(ontap, context, {img = 'profile.jpg'}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            alignment: Alignment.center,
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                color: kwhite, borderRadius: BorderRadius.circular(15)),
            child: Icon(
              Icons.menu,
              size: 30,
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 3,
            ),
            Text("welcome",
                style: TextStyle(
                    fontSize: response.setFontSize(14),
                    color: kprimary.withOpacity(0.8),
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 3,
            ),
            Text("Mohamed Saeed",
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: response.setFontSize(15),
                    color: kprimary,
                    fontWeight: FontWeight.w700)),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () => GoTo(context, ProfileScrean()),
          child: Container(
            alignment: Alignment.center,
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/$img"),
                  fit: BoxFit.fill,
                ),
                color: kwhite,
                borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ],
    ),
  );
}

buildAppBarForPages(context, text, {showProfile = true}) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                color: kwhite.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: 2, color: kscaffoldcolor.withOpacity(0.95))),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              // size: 27,
            ),
          ),
        ),
        Expanded(
          child: Text(text,
              softWrap: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: response.setFontSize(23),
                  color: kprimary,
                  fontWeight: FontWeight.w800)),
        ),
        showProfile
            ? InkWell(
                onTap: () => GoTo(context, ProfileScrean()),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/profile.jpg"),
                      fit: BoxFit.fill,
                    ),
                    color: kwhite,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              )
            : Container(),
      ],
    ),
  );
}

buildSearch({hint, icon = Icons.search, onChange}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration:
        BoxDecoration(color: kwhite, borderRadius: BorderRadius.circular(20)),
    child: TextField(
      onChanged: onChange,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: response.setHeight(15),
              horizontal: response.setWidth(10)),
          suffixIcon: Icon(
            icon,
            size: 30,
            color: kprimary,
          ),
          border: InputBorder.none,
          hintText: hint),
    ),
  );
}

Widget buildDrawer(context) {
  final app = Provider.of<AppProvider>(context, listen: false);
  return Selector<AppProvider, int>(
    selector: (context, app) => app.index,
    builder: (context, i, w) => Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
          color: Color(0xff3f4075),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50))),
      child: Stack(
        children: [
          ClipPath(
            clipper: custumLinearclipperForDrawer(),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment(1, 0),
                      end: Alignment(1, 0.5),
                      colors: [
                    Color(0xff3d4183),
                    Color(0xff3f4075),
                  ])),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildBackButton(context),
              InkWell(
                onTap: () => GoTo(context, ProfileScrean()),
                child: Container(
                  alignment: Alignment.center,
                  height: response.setHeight(100),
                  width: response.setWidth(100),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: kwhite,
                      image: DecorationImage(
                        image: AssetImage("assets/images/profile.jpg"),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              SizedBox(
                height: response.setHeight(10),
              ),
              Text('mohaed saeed',
                  style: TextStyle(
                      fontSize: response.setFontSize(16),
                      color: kwhite,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: response.setHeight(5),
              ),
              Text('@mohaed',
                  style: TextStyle(
                      fontSize: response.setFontSize(14),
                      color: ksecondary,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: response.setHeight(40),
              ),
              buildDrawerItem("Home", 0, i, 6, () {
                app.changeIndex(0);
                Navigator.of(context).pop();
                GoTo(context, HomeScrean());
              }),
              SizedBox(
                height: response.setHeight(20),
              ),
              buildDrawerItem("My Course", 1, i, 2, () {
                app.changeIndex(1);
                Navigator.of(context).pop();

                GoTo(context, CouresScrean());
              }),
              SizedBox(
                height: response.setHeight(20),
              ),
              buildDrawerItem("Shop", 2, i, 4, () {
                app.changeIndex(2);
                Navigator.of(context).pop();

                GoTo(context, ShopScrean());
              }),
              SizedBox(
                height: response.setHeight(20),
              ),
              buildDrawerItem("Cart", 3, i, 7, () {
                app.changeIndex(3);
                Navigator.of(context).pop();

                GoTo(context, CartScrean());
              }),
              SizedBox(
                height: response.setHeight(20),
              ),
              buildDrawerItem("Orders", 4, i, 1, () {
                app.changeIndex(4);
                Navigator.of(context).pop();

                GoTo(context, OrderScrean());
              }),
              SizedBox(
                height: response.setHeight(20),
              ),
              buildDrawerItem("Settings", 5, i, 5, () {
                app.changeIndex(5);
                Navigator.of(context).pop();

                GoTo(context, AchieveScrean());
              }),
            ],
          )
        ],
      ),
    ),
  );
}

Widget buildDrawerItem(text, index, currant, icon, onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 25),
      margin: EdgeInsets.only(left: 50),
      decoration: BoxDecoration(
          border: index == currant
              ? Border(
                  left: BorderSide(
                      color: kprimary2, width: 2, style: BorderStyle.solid))
              : null),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("assets/images/icon$icon.png"),
          SizedBox(
            width: response.setWidth(15),
          ),
          Text(text,
              style: TextStyle(
                  fontSize: response.setFontSize(15),
                  color: kwhite,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    ),
  );
}

GoTo(context, page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}

Widget buildBackButton(context) {
  return Container(
    margin: EdgeInsets.all(32),
    alignment: Alignment.centerRight,
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
            color: kwhite, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: kicon,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buldinputContainer({
  text,
  widget,
  hint,
  TextEditingController controller,
  onpressed,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1.5,
          color: (controller.text.isNotEmpty) ? kprimary2 : ksecondary,
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(text,
                    style: TextStyle(
                        color: kprimary2,
                        fontSize: 18,
                        fontWeight: FontWeight.w900)),
              ),
              text == "Address" || text == "Location"
                  ? Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: kprimary.withOpacity(0.3),
                          shape: BoxShape.circle),
                      child: IconButton(
                          onPressed: onpressed,
                          icon: Icon(
                            Icons.location_on,
                            color: kwhite,
                          )),
                    )
                  : Container()
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: widget == "phone"
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IntlPhoneField(
                        controller: controller,
                        style: TextStyle(
                            color: kprimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                        initialCountryCode: "EG",
                        keyboardType: TextInputType.phone,
                        autoValidate: true,
                        countryCodeTextColor: kprimary,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                          border: InputBorder.none,
                          alignLabelWithHint: true,
                          labelText: "",
                          hintText: "enter phone number",
                          hintStyle: TextStyle(
                              color: ksecondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        onChanged: (phone) {},
                        onCountryChanged: (phone) {
                          print(phone.countryCode);
                        },
                      ),
                    )
                  : widget != null
                      ? widget
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            controller: controller,
                            cursorColor: kprimary,
                            maxLength: text == "Weight" ? 3 : null,
                            keyboardType:
                                text == "Weight" ? TextInputType.number : null,
                            style: TextStyle(
                                color: kprimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                            decoration: InputDecoration(
                                counterText: '',
                                hintStyle: TextStyle(
                                    color: ksecondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                                border: InputBorder.none,
                                hintText: hint),
                          ),
                        ),
            ),
            text == "Address"
                ? Container()
                : text == "Weight"
                    ? Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kg",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 20),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Image.asset(
                                "assets/images/check.png",
                                height: 25,
                                width: 25,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Image.asset(
                          "assets/images/check.png",
                          height: 25,
                          width: 25,
                          fit: BoxFit.fill,
                        ),
                      )
          ],
        ),
      ],
    ),
  );
}
