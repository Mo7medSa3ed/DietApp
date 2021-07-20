import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/models/product.dart';
import 'package:flutter_test_app/pages/cart.dart';
import 'package:flutter_test_app/pages/course.dart';
import 'package:flutter_test_app/pages/home.dart';
import 'package:flutter_test_app/pages/login.dart';
import 'package:flutter_test_app/pages/orders.dart';
import 'package:flutter_test_app/pages/profile.dart';
import 'package:flutter_test_app/pages/shop.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:response/response.dart';
import 'package:toast/toast.dart';

final response = ResponseUI.instance;

Widget buildFillElevatedButton(
    {text, onpressed, bgcolor = kprimary2, txtcolor, elevation}) {
  return ElevatedButton(
    onPressed: onpressed,
    child: Text(text.toString().trim(),
        style: TextStyle(
            color: txtcolor ?? kwhite.withOpacity(0.9),
            fontWeight: FontWeight.w900,
            fontSize: response.setFontSize(16))),
    style: ButtonStyle(
        elevation:
            elevation != null ? MaterialStateProperty.all(elevation) : null,
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 15, horizontal: 25)),
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
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 30,
      height: 25,
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
    {icon, label, onpressed, color = kwhite, bg = kprimary2, fontSize = 16.0}) {
  return ElevatedButton.icon(
    label: Text(label,
        style: TextStyle(
          color: color,
          fontSize: response.setFontSize(fontSize.toDouble()),
          fontWeight: FontWeight.w900,
        )),
    onPressed: onpressed,
    icon: icon,
    style: ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 12, horizontal: 18)),
        backgroundColor: MaterialStateProperty.all<Color>(bg),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
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
          fontSize: response.setFontSize(fontSize.toDouble()),
          fontWeight: FontWeight.w900),
    ),
    onPressed: onpressed,
    icon: icon,
    style: ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 10, horizontal: 18)),
        backgroundColor: MaterialStateProperty.all<Color>(kwhite),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          side: BorderSide(
            color: kprimary.withOpacity(0.6),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(50),
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
                          fontWeight: FontWeight.w800,
                          fontSize: response.setFontSize(16)),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 8,
                  ),
                  Text(desc,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: kprimary.withOpacity(0.5),
                          fontSize: response.setFontSize(12)),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 12,
                  ),
                  buildOutElevatedButton(
                      text: "Continue Shopping",
                      onpressed: () {
                        goToWithRemoveUntill(context, ShopScrean());
                      },
                      test: test),
                  SizedBox(
                    height: 8,
                  ),
                  buildFillElevatedButton(
                      text: "Go To Orders",
                      onpressed: () {
                        goToWithRemoveUntill(context, OrderScrean());
                      }),
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
                  SizedBox(
                    height: 5,
                  ),
                  Text(desc,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: ksecondary,
                          fontSize: response.setFontSize(14)),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 10,
                  ),
                  buildFillElevatedButton(text: conText, onpressed: conTap),
                  buildOutElevatedButton(
                      text: backText, onpressed: backTap, test: test),
                ],
              ),
            ),
          ));
}

buildCartItem(ProductModel p, ondelete) {
 
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 2, bottom: 10, top: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: kwhite),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey[200]),
                  child: Image.network(
                    p.photo,
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
                      Text(p.name,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                              color: kprimary,
                              fontWeight: FontWeight.w900,
                              fontSize: response.setFontSize(16))),
                      SizedBox(
                        height: response.setHeight(4),
                      ),
                      Text(
                        p.description,
                        softWrap: false,
                        style: TextStyle(
                            color: ksecondary,
                            fontWeight: FontWeight.w900,
                            fontSize: response.setFontSize(13.0)),
                        overflow: TextOverflow.fade,
                      ),
                      SizedBox(
                        height: response.setHeight(4),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Text(
                                "\$ ${p.price}",
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: kprimary,
                                    fontWeight: FontWeight.w900,
                                    fontSize: response.setFontSize(16)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: StatefulBuilder(
                                builder: (ctx, s) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    buildIconButton(
                                        icon: Icons.remove,
                                        onpressed: () async {
                                          if (p.amount == 1) return;
                                          final amount = await API
                                              .decreaseQtyCart(p.cartId);
                                          s(() {
                                            p.amount = amount ?? 0;
                                          });
                                        }),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        p.amount.toString(),
                                        softWrap: false,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: kprimary,
                                            fontWeight: FontWeight.w900,
                                            fontSize: response.setFontSize(14)),
                                      ),
                                    ),
                                    buildIconButton(
                                        icon: Icons.add,
                                        onpressed: () async {
                                          final amount = await API
                                              .increaseQtyCart(p.cartId);
                                          s(() {
                                            p.amount = amount ?? 0;
                                          });
                                        }),
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
        IconButton(
            onPressed: ondelete,
            icon: Icon(
              Icons.delete_forever,
              color: kprimary,
              size: 40,
            ))
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
          padding: EdgeInsets.all(10),
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
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: kprimary,
                          fontWeight: FontWeight.w900,
                          fontSize: response.setFontSize(16.2))),
                  SizedBox(
                    height: response.setHeight(2),
                  ),
                  Text("Forevver Therm",
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: ksecondary,
                          fontWeight: FontWeight.w900,
                          fontSize: response.setFontSize(14))),
                  SizedBox(
                    height: response.setHeight(2),
                  ),
                  Text("x 1",
                      overflow: TextOverflow.fade,
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

buildShopItem({context, ProductModel product}) {
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
              padding: EdgeInsets.all(10),
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
                    child: Image.network(product.photo),
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
                            child: Text(product.name,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: kprimary,
                                    fontWeight: FontWeight.w900,
                                    fontSize: response.setFontSize(16))),
                          ),
                          buildText(
                              "\$ " +
                                  double.parse(product.price.toString())
                                      .toStringAsFixed(1),
                              color: kprimary2,
                              fontsize: 18.0),
                          SizedBox(
                            width: 8,
                          )
                        ]),
                        SizedBox(
                          height: 2,
                        ),
                        Text(product.description,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: ksecondary,
                                fontWeight: FontWeight.w900,
                                fontSize: response.setFontSize(14))),
                        SizedBox(
                          height: 2,
                        ),
                        // Expanded(
                        //   child: StatefulBuilder(
                        //       builder: (ctx, s) => Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               buildIconButton(
                        //                   icon: Icons.remove,
                        //                   onpressed: () {
                        //                     if (product.amount == 1) return;
                        //                     s(() {
                        //                       product.amount--;
                        //                     });
                        //                   }),
                        //               SizedBox(
                        //                 width: 16,
                        //               ),
                        //               Text(
                        //                 '${product.amount}',
                        //                 style: TextStyle(
                        //                     color: kprimary,
                        //                     fontWeight: FontWeight.w900,
                        //                     fontSize: response.setFontSize(14)),
                        //               ),
                        //               SizedBox(
                        //                 width: 16,
                        //               ),
                        //               buildIconButton(
                        //                   icon: Icons.add,
                        //                   onpressed: () {
                        //                     s(() {
                        //                       product.amount++;
                        //                     });
                        //                   }),
                        //             ],
                        //           )),
                        // ),
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
          mini: true,
          backgroundColor: kdrawer,
          elevation: 4,
          onPressed: () async {
            final res = await API.addToCart(product.id);
            if (res != false) {
              Provider.of<AppProvider>(context, listen: false)
                  .changeCartCount(int.parse(res['amount'].toString()));
              Toast.show("Product added to cart successfully", context,
                  backgroundColor: kprimary,
                  textColor: kwhite,
                  gravity: Toast.BOTTOM,
                  duration: Toast.LENGTH_SHORT);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/cart.png"),
          ),
        ),
      )
    ],
  );
}

buildText(text, {color = kprimary, fontsize}) {
  return Text(text.toString().trim(),
      overflow: TextOverflow.fade,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: fontsize != null
              ? response.setFontSize(fontsize.toDouble())
              : response.setFontSize(17)));
}

buildText2(text, {color = ksecondary, fontsize}) {
  return Text(text.toString().trim(),
      overflow: TextOverflow.fade,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: fontsize != null
              ? response.setFontSize(fontsize.toDouble())
              : response.setFontSize(15)));
}

buildOrderItem(o) {
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
                  child: buildText2("Client Name : ", fontsize: 14),
                ),
                Expanded(
                  flex: 20,
                  child: buildText(o['user_name'], fontsize: 15),
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
                  child: buildText2("Address : ", fontsize: 14),
                ),
                Expanded(
                  flex: 20,
                  child: buildText(o['user_address'], fontsize: 15),
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
                  child: buildText2("Phone : ", fontsize: 14),
                ),
                Expanded(
                  flex: 20,
                  child: buildText(o['user_mobile'], fontsize: 15),
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
                  child: buildText2("Order : ", fontsize: 14),
                ),
                Expanded(
                    flex: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          o['cart_data'].length,
                          (index) => buildText(
                              '${o['cart_data'][index]['quantity']} x ${o['cart_data'][index]['buyable']['name']}',
                              fontsize: 15)),
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
                  child: buildText2("Total Price : ", fontsize: 14),
                ),
                Expanded(
                  flex: 20,
                  child: buildText(
                      "\$ ${double.parse(o['total']).toStringAsFixed(1)}",
                      fontsize: 15),
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
                  child: buildText2("Date : ", fontsize: 14),
                ),
                Expanded(
                  flex: 20,
                  child: buildText(o['updated_at'], fontsize: 15),
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
                  child: buildText2("Status : ", fontsize: 14),
                ),
                Expanded(
                  flex: 20,
                  child: buildText2(o['status'], fontsize: 14),
                ),
              ],
            ),
            SizedBox(
              height: response.setHeight(15),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildIconElevatedButton(
                    label: 'Edit Order',
                    icon: Image.asset("assets/images/edit-button.png"),
                    onpressed: () {}),
                buildIconElevatedButtonOutLine(
                    label: 'Cancel',
                    color: kprimary2,
                    icon: Icon(
                      Icons.close,
                      color: kprimary2,
                      size: 25,
                    ),
                    onpressed: () {}),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

buildAppBar(
  ontap,
  context,
) {
  var user = Provider.of<AppProvider>(context, listen: false).user;
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            alignment: Alignment.center,
            width: response.setHeight(45),
            height: response.setHeight(45),
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
            Text(user['name'] ?? '',
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: response.setFontSize(15),
                    color: kprimary,
                    fontWeight: FontWeight.w700)),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () => goTo(context, ProfileScrean()),
          child: Container(
            alignment: Alignment.center,
            width: response.setHeight(45),
            height: response.setHeight(45),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(user['photo']),
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

buildAppBarForPages(context, text, press, {showProfile = true}) {
  var user = Provider.of<AppProvider>(context, listen: false).user;
  return Container(
    padding: EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: press,
          child: Container(
            alignment: Alignment.center,
            width: response.setHeight(45),
            height: response.setHeight(45),
            decoration: BoxDecoration(
                color: kwhite, borderRadius: BorderRadius.circular(15)),
            child: Icon(
              Icons.menu,
              size: 30,
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
                onTap: () => goTo(context, ProfileScrean()),
                child: Container(
                  width: response.setHeight(45),
                  height: response.setHeight(45),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(user['photo']),
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

buildSearch(
    {hint,
    label,
    autoValidate = false,
    icon = Icons.search,
    enabled,
    onChange,
    onValidate,
    maxlength,
    keyboard}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration:
        BoxDecoration(color: kwhite, borderRadius: BorderRadius.circular(20)),
    child: TextFormField(
      enabled: enabled,
      onChanged: onChange,
      maxLength: maxlength,
      validator: onValidate,
      obscureText: label == 'Password' ? true : false,
      autovalidateMode:
          autoValidate ? AutovalidateMode.onUserInteraction : null,
      keyboardType: keyboard,
      inputFormatters: keyboard == TextInputType.number
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      decoration: InputDecoration(
          labelText: label,
          counterText: '',
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
  var user = Provider.of<AppProvider>(context, listen: false).user;
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
            clipper: CustumLinearclipperForDrawer(),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => goTo(context, ProfileScrean()),
                        child: Container(
                          alignment: Alignment.center,
                          height: response.setHeight(100),
                          width: response.setHeight(100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: kwhite,
                              image: DecorationImage(
                                image: NetworkImage(user['photo']),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: response.setHeight(10),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(user['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: response.setFontSize(16),
                                color: kwhite,
                                fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: response.setHeight(5),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text('',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: response.setFontSize(14),
                                color: ksecondary,
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(
                        height: response.setHeight(40),
                      ),
                      buildDrawerItem("Home", 0, i, 6, () {
                        app.changeIndex(0);
                        Navigator.of(context).pop();
                        goTo(context, HomeScrean());
                      }),
                      SizedBox(
                        height: response.setHeight(20),
                      ),
                      buildDrawerItem("My Course", 1, i, 2, () {
                        app.changeIndex(1);
                        Navigator.of(context).pop();

                        goTo(context, CouresScrean());
                      }),
                      SizedBox(
                        height: response.setHeight(20),
                      ),
                      buildDrawerItem("Shop", 2, i, 4, () {
                        app.changeIndex(2);
                        Navigator.of(context).pop();

                        goTo(context, ShopScrean());
                      }),
                      SizedBox(
                        height: response.setHeight(20),
                      ),
                      buildDrawerItem("Cart", 3, i, 7, () {
                        app.changeIndex(3);
                        Navigator.of(context).pop();

                        goTo(context, CartScrean());
                      }),
                      SizedBox(
                        height: response.setHeight(20),
                      ),
                      buildDrawerItem("Orders", 4, i, 1, () {
                        app.changeIndex(4);
                        Navigator.of(context).pop();

                        goTo(context, OrderScrean());
                      }),
                      SizedBox(
                        height: response.setHeight(20),
                      ),
                      buildDrawerItem("Settings", 5, i, 5, () {
                        app.changeIndex(5);
                        Navigator.of(context).pop();
                      }),
                      SizedBox(
                        height: response.setHeight(20),
                      ),
                      buildDrawerItem("Logout", 6, i, 6, () async {
                        app.changeIndex(6);
                        Navigator.of(context).pop();
                        if (await clear())
                          goToWithRemoveUntill(context, LoginScrean());
                      }),
                    ],
                  ),
                ),
              ),
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
          index == 6
              ? Icon(Icons.exit_to_app, color: kwhite)
              : Image.asset("assets/images/icon$icon.png"),
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

goTo(context, page, {then}) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => page))
      .then(then ?? (v) {});
}

goToWithReplace(context, page) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => page));
}

goToWithRemoveUntill(context, page) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page), (Route<dynamic> route) => false);
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
        width: response.setHeight(45),
        height: response.setHeight(45),
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

Widget buldinputContainer(
    {text,
    widget,
    hint,
    TextEditingController controller,
    onpressed,
    onChange,
    validator,
    isLoading = false,
    phoneMaxLength = 10,
    onCountryChanged}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              child: /*  widget == "phone"
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: IntlPhoneField(
                        validator: (v) {
                          if (v.trim().isEmpty || v == null) {
                            return "please enter your phone ....";
                          } else if (phoneMaxLength != null) {
                            if (v.length > phoneMaxLength)
                              return "phone must be $phoneMaxLength numbers ....";
                            return null;
                          }
                          return null;
                        },
                        autoValidate: false,
                        controller: controller,
                        style: TextStyle(
                            color: kprimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                        initialCountryCode: "EG",
                        onCountryChanged: onCountryChanged,
                        maxLength: phoneMaxLength,
                        keyboardType: TextInputType.phone,
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
                        onChanged: onChange,
                      ),
                    )
                  : */
                  widget != null
                      ? widget
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: controller,
                            onChanged: onChange,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: validator != null
                                ? validator
                                : (String v) {
                                    if (v.trim().isEmpty || v == null) {
                                      return 'please enter your ${text.toLowerCase()}...';
                                    }
                                    return null;
                                  },
                            cursorColor: kprimary,
                            maxLength: (text == "Weight") || (text == "Height")
                                ? 3
                                : (text == "Age")
                                    ? 2
                                    : (text == "Phone")
                                        ? 11
                                        : null,
                            inputFormatters: (text == "Age")
                                ? [FilteringTextInputFormatter.digitsOnly]
                                : null,
                            keyboardType: (text == "Weight") ||
                                    (text == "Height") ||
                                    (text == "Age") ||
                                    (text == "Phone")
                                ? TextInputType.number
                                : null,
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
            /*      text == "Address"
                ? Container()
                :  */
            (text == "Weight") || (text == "Height")
                ? Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (text == "Weight") ? "kg" : "cm",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.asset(
                            "assets/images/check.png",
                            height: 22,
                            color: controller.text.isNotEmpty
                                ? kprimary2
                                : ksecondary,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(right: 8.0),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: kprimary,
                          )
                        : Image.asset(
                            "assets/images/check.png",
                            height: 22,
                            color: controller.text.isNotEmpty
                                ? kprimary2
                                : ksecondary,
                            fit: BoxFit.fill,
                          ),
                  )
          ],
        ),
      ],
    ),
  );
}
