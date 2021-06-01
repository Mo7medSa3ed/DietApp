import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/map.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:geolocator/geolocator.dart';
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

  getCurrantLocation() async {
    await Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.always ||
          value == LocationPermission.whileInUse) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => MapScrean()));
      } else {
        buildDialogforNotification(
            context: context,
            test: false,
            text: "Allow your Location",
            desc: "we will need your location to give you better experience.",
            img: "location.png",
            conTap: () {
              Navigator.of(context).pop();
              Geolocator.requestPermission().then((value) {
                if (value == LocationPermission.always ||
                    value == LocationPermission.whileInUse) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => MapScrean()));
                } else {
                  Navigator.of(context).pop();
                }
              });
            },
            backTap: () {
              Navigator.of(context).pop();
            },
            conText: "Sure, I'd Like that",
            backText: "Not now");
      }
    });
  }

  @override
  void initState() {
    getCurrantaddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                          controller: TextEditingController(text: ''),
                          text: "Address",
                          widget: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      address != null ? address.toString() : '',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: kprimary)),
                                ),
                                address == null
                                    ? Container(
                                        child: CircularProgressIndicator(
                                        color: kprimary,
                                      ))
                                    : Container()
                              ],
                            ),
                          ),
                        ),
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
                                return buildDialog(
                                  context: context,
                                  test: true,
                                  text: "Your order is successfully.",
                                  desc:
                                      "we can track the delivery in the orders section",
                                  img: "image5.png",
                                );
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

  Widget buldinputContainer(
      {text, widget, hint, TextEditingController controller}) {
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
                text == "Address"
                    ? Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: kprimary.withOpacity(0.3),
                            shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () async {
                              await getCurrantLocation();
                            },
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
                          controller: _phone,
                          style: TextStyle(
                              color: kprimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                          initialCountryCode: 'EG',
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
                          onCountryChanged: (phone) {},
                        ),
                      )
                    : widget != null
                        ? widget
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              controller: controller,
                              cursorColor: kprimary,
                              style: TextStyle(
                                  color: kprimary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                              decoration: InputDecoration(
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
}
