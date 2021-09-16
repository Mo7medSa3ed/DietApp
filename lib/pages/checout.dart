
import 'package:flutter/material.dart';
import 'package:flutter_test_app/API.dart';
import 'package:flutter_test_app/Alert.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';

class CheckoutScrean extends StatefulWidget {
  @override
  _CheckoutScreanState createState() => _CheckoutScreanState();
}

class _CheckoutScreanState extends State<CheckoutScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController(text: '');
  var _phone = TextEditingController(text: '');
  var _address = TextEditingController(text: '');
  var user;
  double total = 0.0;
  Address addresses;
  bool isLoading = false;

  @override
  void initState() {
    getData();

    user = Provider.of<AppProvider>(context, listen: false).user;

    _nameController.text = user['name'];
    _phone.text = user['mobile'].toString().replaceAll("+2", '');
    _address.text = user['location'];
    super.initState();
  }

  getData() async {
    final res = await API.getCart();
    if (res == 'error') return Alert.errorAlert(ctx: context, title: errorMsg);
    if (res != null) {
      final t =
          double.parse(res['data']['total'].toString()).toStringAsFixed(1);
      total = double.parse(t);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldkey,
            drawer: buildDrawer(context),
            backgroundColor: kcolor1,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kcolor1, Colors.grey[300], kcolor1])),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          buildAppBarForPages(
                            context,
                            "Checkout",
                            () => scaffoldkey.currentState.openDrawer(),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: buildText("Delivery data")),
                          buldinputContainer(
                              text: "Client Name",
                              hint: 'Enter client name ...',
                              controller: _nameController),
                          /*        buldinputContainer(
                              text: "Country",
                              widget: buildCountrySelector(),
                              controller: TextEditingController()),
                          buldinputContainer(
                              text: "City",
                              widget: buildCountrySelector(),
                              controller: TextEditingController()), */
                          buldinputContainer(
                              controller: _address,
                              text: "Address",
                              isLoading: isLoading,
                              onpressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                addresses = await getCurrantaddress();
                                _address.text = addresses.addressLine;

                                setState(() {
                                  isLoading = false;
                                });
                              },
                              hint: 'Enter your address'),
                          buldinputContainer(
                              onChange: (v) {
                                if (v.length == 0 || v.length == 1)
                                  setState(() {});
                              },
                              text: "Phone",
                              hint: 'Enter mobile phone ...',
                              controller: _phone),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: ksecondary,
                              offset: Offset(0, -5),
                              blurRadius: 10,
                              spreadRadius: 2)
                        ],
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        buildRowForBottomsheet(
                            text: "Cart total", price: total),
                        SizedBox(
                          height: 4,
                        ),
                        buildRowForBottomsheet(text: "Shipping", price: 0.0),
                        SizedBox(
                          height: 4,
                        ),
                        buildRowForBottomsheet(
                            text: "Promo Discount", price: 0.0),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText("Total", fontsize: 18.0),
                            buildText("\$ $total", fontsize: 18.0),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            child: buildFillElevatedButton(
                                text: "Order",
                                onpressed: () async {
                                  await makeOrder();
                                }))
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  makeOrder() async {
    if (!(formKey.currentState.validate())) return;
    Alert.loadingAlert(ctx: context);
    final body = {
      "user_name": _nameController.text.trim().isEmpty
          ? user['name']
          : _nameController.text.trim(),
      "user_address": _address.text.trim().isEmpty
          ? user['location']
          : _address.text.trim(),
      "user_mobile": (_phone.text.trim().isEmpty)
          ? user['mobile'].toString().replaceAll("+2", '')
          : "+2" + _phone.text.trim(),
      "user_country": addresses != null ? addresses.countryName : 'Egypt adas',
      "user_city": addresses != null ? addresses.subAdminArea : "Minya",
    };
    print(body);
    final res = await API.makeOrder(body);
    Navigator.of(context).pop();
    if (res == 'error') {
      return Alert.errorAlert(ctx: context, title: "Something went wrong...");
    }

    final data = res.data;
 
    if ((res.statusCode == 200 || res.statusCode == 201) && data['success']) {
      return buildDialog(
        context: context,
        test: true,
        text: "Your order is successfully.",
        desc: "we can track the delivery in the orders section",
        img: "image5.png",
      );
    } else if (res.statusCode != 200 || !data['success']) {
      return Alert.errorAlert(ctx: context, title: data['message']);
    } else {
      return Alert.errorAlert(ctx: context, title: "Something went wrong...");
    }
  }

  // Padding buildCountrySelector() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //     child: CSCPicker(
  //       flagState: CountryFlag.ENABLE,
  //       showCities: false,
  //       showStates: false,
  //       dropdownDecoration: BoxDecoration(color: null),
  //       defaultCountry: DefaultCountry.Egypt,
  //       selectedItemStyle: TextStyle(
  //           color: kprimary, fontSize: 20, fontWeight: FontWeight.w900),
  //       dropdownHeadingStyle: TextStyle(
  //           color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
  //       dropdownItemStyle: TextStyle(
  //         color: Colors.black,
  //         fontSize: 14,
  //       ),
  //       disabledDropdownDecoration: BoxDecoration(color: null),
  //       dropdownDialogRadius: 10.0,
  //       searchBarRadius: 10.0,
  //       onCountryChanged: (value) {
  //         setState(() {
  //           countrySelected = value;
  //         });
  //       },
  //       onCityChanged: (v) {},
  //       onStateChanged: (v) {},
  //     ),
  //   );
  // }

  // Padding buildCitySelector() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //     child: CSCPicker(
  //       flagState: CountryFlag.ENABLE,
  //       showCities: true,
  //       showStates: true,
  //       dropdownDecoration: BoxDecoration(color: null),
  //       disabledDropdownDecoration: BoxDecoration(color: null),
  //       selectedItemStyle: TextStyle(
  //           color: kprimary, fontSize: 20, fontWeight: FontWeight.w900),
  //       dropdownHeadingStyle: TextStyle(
  //           color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
  //       dropdownItemStyle: TextStyle(
  //         color: Colors.black,
  //         fontSize: 14,
  //       ),
  //       dropdownDialogRadius: 10.0,
  //       searchBarRadius: 10.0,
  //       onCountryChanged: (value) {
  //         setState(() {
  //           countrySelected = value;
  //         });
  //       },
  //       onCityChanged: (value) {
  //         setState(() {
  //           citySelected = value;
  //         });
  //       },
  //       onStateChanged: (value) {},
  //     ),
  //   );
  // }

  Widget buildRowForBottomsheet({text, double price}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildText2(text, fontsize: 15.0),
          buildText2(price >= 0 ? "\$ $price" : "-\$ ${price * -1}",
              fontsize: 15.0),
        ],
      ),
    );
  }

  // Widget buldinputContainer(
  //     {text, widget, hint, TextEditingController controller}) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20),
  //         border: Border.all(
  //           width: 1.5,
  //           color: (controller.text.isNotEmpty) ? kprimary2 : ksecondary,
  //         )),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           height: 12,
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: Text(text,
  //                     style: TextStyle(
  //                         color: kprimary2,
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.w900)),
  //               ),
  //               text == "Address"
  //                   ? Container(
  //                       width: 40,
  //                       height: 40,
  //                       decoration: BoxDecoration(
  //                           color: kprimary.withOpacity(0.3),
  //                           shape: BoxShape.circle),
  //                       child: IconButton(
  //                           onPressed: () async {
  //                             await getCurrantLocation(context);
  //                           },
  //                           icon: Icon(
  //                             Icons.location_on,
  //                             color: kwhite,
  //                           )),
  //                     )
  //                   : Container()
  //             ],
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: widget == "phone"
  //                   ? Padding(
  //                       padding: const EdgeInsets.only(left: 10.0),
  //                       child: IntlPhoneField(
  //                         controller: _phone,
  //                         style: TextStyle(
  //                             color: kprimary,
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.w900),
  //                         initialCountryCode: 'EG',
  //                         countryCodeTextColor: kprimary,
  //                         decoration: InputDecoration(
  //                           contentPadding: EdgeInsets.all(0),
  //                           isDense: true,
  //                           border: InputBorder.none,
  //                           alignLabelWithHint: true,
  //                           labelText: "",
  //                           hintText: "enter phone number",
  //                           hintStyle: TextStyle(
  //                               color: ksecondary,
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.w700),
  //                         ),
  //                         onChanged: (phone) {},
  //                         onCountryChanged: (phone) {},
  //                       ),
  //                     )
  //                   : widget != null
  //                       ? widget
  //                       : Padding(
  //                           padding:
  //                               const EdgeInsets.symmetric(horizontal: 20.0),
  //                           child: TextField(
  //                             controller: controller,
  //                             cursorColor: kprimary,
  //                             style: TextStyle(
  //                                 color: kprimary,
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.w900),
  //                             decoration: InputDecoration(
  //                                 hintStyle: TextStyle(
  //                                     color: ksecondary,
  //                                     fontSize: 18,
  //                                     fontWeight: FontWeight.w700),
  //                                 border: InputBorder.none,
  //                                 hintText: hint),
  //                           ),
  //                         ),
  //             ),
  //             text == "Address"
  //                 ? Container()
  //                 : Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //                     child: Image.asset(
  //                       "assets/images/check.png",
  //                       height: 25,
  //                       width: 25,
  //                       fit: BoxFit.fill,
  //                     ),
  //                   )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
