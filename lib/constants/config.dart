import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';

const ksecondary = Color.fromARGB(255, 142, 156, 182);
const kprimary = Color.fromARGB(255, 23, 29, 45);
const kprimary2 = Color.fromARGB(255, 70, 92, 214);
const kdrawer = Color.fromARGB(255, 63, 64, 117);
const kicon = Color.fromARGB(255, 112, 112, 112);
const kscaffoldcolor = Color.fromARGB(255, 204, 208, 233);
const ktextcolor = Color.fromARGB(255, 23, 29, 45);
const kbackcolor = Color.fromARGB(255, 35, 39, 73);
const kcolor1 = Color.fromARGB(255, 213, 217, 245);
const kcolor2 = Color.fromARGB(255, 35, 39, 73);
const kcolor3 = Color.fromARGB(255, 35, 39, 73);
const kwhite = Colors.white;
const kgreen = Color(0xff00c488);
const kblue = Color(0xff3f4075);
const APIKEY = "AIzaSyDXgbuvH4h_A7OkEbqAucUKQSLUfJs8i2Y";
const img =
    "https://digitaldefynd.com/wp-content/uploads/2020/04/Best-Food-Styling-course-tutorial-class-certification-training-online-1024x625.jpg";
var errorMsg = tr('error404');
// "\nplease send correct data or check network status!!";
setValue({key, value}) async {
  SharedPreferences prfs = await SharedPreferences.getInstance();
  prfs.setString(key, value);
}

Future<dynamic> getValue({key}) async {
  SharedPreferences prfs = await SharedPreferences.getInstance();
  final value = prfs.get(key);
  return value;
}

Future<dynamic> clear() async {
  SharedPreferences prfs = await SharedPreferences.getInstance();
  prfs.clear();
  return true;
}

Future<dynamic> getHeader() async {
  final res = await getValue(key: 'token');
  final token = res != null ? jsonDecode(res) : '';
  final header = <String, String>{
    'Content-Type': 'application/json;charset=UTF-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
  return header;
}

Future<dynamic> getCurrantaddress() async {
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
  final l = await location.getLocation();

  List<Address> add = await Geocoder.local
      .findAddressesFromCoordinates(Coordinates(l.latitude, l.longitude));

  return add.first;
}

// getCurrantLocation(context) async {
//   await Geolocator.checkPermission().then((value) {
//     if (value == LocationPermission.always ||
//         value == LocationPermission.whileInUse) {
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (_) => MapScrean()));
//     } else {
//       buildDialogforNotification(
//           context: context,
//           test: false,
//           text: "Allow your Location",
//           desc: "we will need your location to give you better experience.",
//           img: "location.png",
//           conTap: () {
//             Navigator.of(context).pop();
//             Geolocator.requestPermission().then((value) {
//               if (value == LocationPermission.always ||
//                   value == LocationPermission.whileInUse) {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (_) => MapScrean()));
//               } else {
//                 Navigator.of(context).pop();
//               }
//             });
//           },
//           backTap: () {
//             Navigator.of(context).pop();
//           },
//           conText: "Sure, I'd Like that",
//           backText: "Not now");
//     }
//   });
// }

class CustumLinearclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height * 0.85);

    path.quadraticBezierTo(
        0, size.height * 0.6 + 60, size.width / 3, size.height * 0.6 + 60);

    path.quadraticBezierTo(
        size.width, size.height * 0.6 + 60, size.width, size.height * 0.5);

    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustumLinearclipperForDrawer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.4);
    path.lineTo(0, size.height * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
