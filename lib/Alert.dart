import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test_app/constants/config.dart';

class Alert {
  static sucessAlert({ctx, text, title, ontap}) {
    return showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (c) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/image5.png",
                      height: 150,
                    ),
                    SizedBox(height: 16),
                    Text(title ?? '',
                        style: TextStyle(
                            fontSize: 20,
                            color: ktextcolor,
                            fontWeight: FontWeight.w800)),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      text ?? "",
                      style: TextStyle(
                          fontSize: 16,
                          color: ksecondary,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: 80,
                      child: ElevatedButton(
                          onPressed: ontap,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kprimary2),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          ),
                          child: Text(
                            tr('ok'),
                            style: TextStyle(
                                fontSize: 14,
                                color: kwhite,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ),
            ));
  }

  static errorAlert({ctx, title}) {
    return showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (c) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/images/error.svg",
                      height: 150,
                    ),
                    SizedBox(height: 16),
                    Text(tr('error'),
                        style: TextStyle(
                            fontSize: 20,
                            color: ktextcolor,
                            fontWeight: FontWeight.w800)),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      title ?? tr('error404'),
                      style: TextStyle(
                          fontSize: 16,
                          color: ksecondary,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        width: 80,
                        child: ElevatedButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                            child: Text(
                              tr('ok'),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: kwhite,
                                  fontWeight: FontWeight.bold),
                            ))),
                  ],
                ),
              ),
            ));
  }

  static loadingAlert({ctx}) {
    return showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (c) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/images/waiting.svg",
                      height: 150,
                    ),
                    SizedBox(height: 16),
                    Text(tr('loadingTitle'),
                        style: TextStyle(
                            fontSize: 20,
                            color: ktextcolor,
                            fontWeight: FontWeight.w800)),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      tr('loadingdesc'),
                      style: TextStyle(
                          fontSize: 16,
                          color: ksecondary,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ));
  }
}
