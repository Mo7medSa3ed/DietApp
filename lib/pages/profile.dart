import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/edit_profile.dart';
import 'package:flutter_test_app/provider/app_provider.dart';
import 'package:flutter_test_app/widgets/custum.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScrean extends StatefulWidget {
  @override
  _ProfileScreanState createState() => _ProfileScreanState();
}

class _ProfileScreanState extends State<ProfileScrean> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  var user;
  @override
  void initState() {
    user = Provider.of<AppProvider>(context, listen: false).user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldkey,
          drawer: buildDrawer(context),
          resizeToAvoidBottomInset: false,
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildAppBarForPages(context, tr("profile"),
                      () => scaffoldkey.currentState.openDrawer(),
                      showProfile: false),
                  Container(
                      width: 150,
                      height: 150,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: ksecondary,
                              blurRadius: 15,
                              spreadRadius: 2)
                        ],
                        color: kwhite,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: ksecondary,
                        backgroundImage: NetworkImage(user['photo']),
                      )),
                  SizedBox(height: 15),
                  Text(user['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          color: kprimary,
                          fontWeight: FontWeight.w900)),
                  Text(user['email'] ?? '@Mohamed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: ksecondary,
                          fontWeight: FontWeight.w900)),
                  SizedBox(height: 30),
                  Card(
                    color: Color(0xfffefefe),
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    shadowColor: Color(0xfffefefe).withOpacity(0.5),
                    elevation: 10,
                    child: Column(
                      children: [
                        user['name'] != null
                            ? buildContainerForPRoileData(
                                title: tr('name'),
                                subtitle: user['name'],
                                first: true)
                            : Container(),
                        // buildContainerForPRoileData(
                        //   title: "Email",
                        //   subtitle: "MohamedSaeed@gmail.com",
                        // ),
                        user['location'] != null
                            ? buildContainerForPRoileData(
                                title: tr('location'),
                                subtitle: user['location'],
                              )
                            : Container(),

                        user['birth_date'] != null
                            ? buildContainerForPRoileData(
                                title: tr("birthdate"),
                                subtitle: DateFormat('dd/MM/yyyy')
                                    .format(DateTime.parse(user['birth_date']))
                                    .toString(),
                              )
                            : Container(),
                        user['gender'] != null
                            ? buildContainerForPRoileData(
                                title: tr("gender"),
                                subtitle:
                                    '${user['gender'][0].toUpperCase()}${user['gender'].substring(1)}',
                              )
                            : Container(),
                        (user['height'] != null && user['height'] != 0)
                            ? buildContainerForPRoileData(
                                title: tr('height'),
                                subtitle: "${user['height']} cm",
                              )
                            : Container(),
                        (user['weight'] != null && user['weight'] != 0)
                            ? buildContainerForPRoileData(
                                title: tr('weight'),
                                subtitle: "${user['weight']} KG",
                                last: true)
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        // width: 150,
                        // height: 50,
                        child: buildIconElevatedButton(
                          bg: Colors.white,
                          elevation: 5,
                          shadowColor: Colors.white,
                          color: kprimary,
                          icon: Icon(
                            Icons.edit,
                            color: kprimary,
                          ),
                          label: tr("edit"),
                          onpressed: () {
                            goTo(context, EditProfileScrean());
                          },
                        ),
                      ),
                      SizedBox(
                        width: 32,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildContainerForPRoileData(
      {title, subtitle, last = false, first = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: first
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))
                  : last
                      ? BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))
                      : null),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: kprimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      color: kprimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ]),
        ),
        Divider(
          color: kscaffoldcolor.withOpacity(0.5),
          height: 0,
          thickness: 2,
        ),
      ],
    );
  }
}
