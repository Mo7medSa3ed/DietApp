import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/orders.dart';
import 'package:flutter_test_app/pages/shop.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart' as loc;

class CheckoutScrean extends StatefulWidget {
  @override
  _CheckoutScreanState createState() => _CheckoutScreanState();
}

class _CheckoutScreanState extends State<CheckoutScrean> {
  var countrySelected;
  var citySelected;
  var _nameController = TextEditingController(text: '');
  var _phone = TextEditingController(text: '');
  var address;
  getCurrantaddress() async {
    loc.Location location = new loc.Location();

    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.GRANTED) {
        return;
      }
    }
    location.getLocation().then((value) {
      Geocoder.local
          .findAddressesFromCoordinates(
              Coordinates(value.latitude, value.longitude))
          .then((List<Address> val) {
        setState(() {
          address = val.first.addressLine;
        });
      });
    });
  }

  @override
  void initState() {
    // getCurrantaddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                    child: ListView(
                      children: [
                        buildAppBarForPages(context, "Checkout"),
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
                            onpressed: () async {
                              await getCurrantLocation(context);
                            },
                            controller: TextEditingController(text: ''),
                            text: "Address",
                            hint: "enter your address ..."),
                        buldinputContainer(
                            text: "PhoneNumber",
                            widget: "phone",
                            controller: _phone),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: (MediaQuery.of(context).size.height * 0.24) < 215.0
                        ? 215.0
                        : MediaQuery.of(context).size.height * 0.24,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        buildRowForBottomsheet(text: "Cart total", price: 80),
                        SizedBox(
                          height: 4,
                        ),
                        buildRowForBottomsheet(text: "Shipping", price: 10),
                        SizedBox(
                          height: 4,
                        ),
                        buildRowForBottomsheet(
                            text: "Promo Discount", price: -5),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildText("Total", fontsize: 21.0),
                            buildText("\$ 85", fontsize: 21.0),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            child: buildFillElevatedButton(
                              text: "Order",
                              onpressed: () {
                                buildDialogforNotification(
                                    context: context,
                                    test: false,
                                    text: "Your order is successfully.",
                                    desc:
                                        "you can track the delivery in the \"Orders\" section",
                                    img: "image5.png",
                                    conTap: () {
                                      Navigator.of(context).pop();
                                      GoTo(context, ShopScrean());
                                    },
                                    backTap: () {
                                      Navigator.of(context).pop();
                                      GoTo(context, OrderScrean());
                                    },
                                    conText: "Continue Shopping",
                                    backText: "Go to Orders");
                              },
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Padding buildCountrySelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CSCPicker(
        flagState: CountryFlag.ENABLE,
        showCities: false,
        showStates: false,
        dropdownDecoration: BoxDecoration(color: null),
        defaultCountry: DefaultCountry.Egypt,
        selectedItemStyle: TextStyle(
            color: kprimary, fontSize: 20, fontWeight: FontWeight.w900),
        dropdownHeadingStyle: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        dropdownItemStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        disabledDropdownDecoration: BoxDecoration(color: null),
        dropdownDialogRadius: 10.0,
        searchBarRadius: 10.0,
        onCountryChanged: (value) {
          setState(() {
            countrySelected = value;
          });
        },
        onCityChanged: (v) {},
        onStateChanged: (v) {},
      ),
    );
  }

  Padding buildCitySelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CSCPicker(
        flagState: CountryFlag.ENABLE,
        showCities: true,
        showStates: true,
        dropdownDecoration: BoxDecoration(color: null),
        disabledDropdownDecoration: BoxDecoration(color: null),
        selectedItemStyle: TextStyle(
            color: kprimary, fontSize: 20, fontWeight: FontWeight.w900),
        dropdownHeadingStyle: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        dropdownItemStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        dropdownDialogRadius: 10.0,
        searchBarRadius: 10.0,
        onCountryChanged: (value) {
          setState(() {
            countrySelected = value;
          });
        },
        onCityChanged: (value) {
          setState(() {
            citySelected = value;
          });
        },
        onStateChanged: (value) {},
      ),
    );
  }

  Widget buildRowForBottomsheet({text, double price}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildText2(text, fontsize: 18.0),
          buildText2(price > 0 ? "\$ $price" : "-\$ ${price * -1}",
              fontsize: 18.0),
        ],
      ),
    );
  }
}
