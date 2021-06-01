import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/map.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:geolocator/geolocator.dart';

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
const APIKEY ="AIzaSyDXgbuvH4h_A7OkEbqAucUKQSLUfJs8i2Y";
const img ="https://digitaldefynd.com/wp-content/uploads/2020/04/Best-Food-Styling-course-tutorial-class-certification-training-online-1024x625.jpg";




getCurrantLocation(context) async {
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




class custumLinearclipper extends CustomClipper<Path> {
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

class custumLinearclipperForDrawer extends CustomClipper<Path> {
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
