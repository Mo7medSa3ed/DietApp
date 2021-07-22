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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildAppBarForPages(context, "Profile",
                    () => scaffoldkey.currentState.openDrawer(),
                    showProfile: false),
                Container(
                    width: 150,
                    height: 150,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: ksecondary, blurRadius: 15, spreadRadius: 2)
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
                // Text('@mohaed',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //         fontSize: 20,
                //         color: ksecondary,
                //         fontWeight: FontWeight.w900)),
                SizedBox(height: 20),
                user['name'] != null
                    ? buildContainerForPRoileData(
                        title: "Name", subtitle: user['name'], first: true)
                    : Container(),
                // buildContainerForPRoileData(
                //   title: "Email",
                //   subtitle: "MohamedSaeed@gmail.com",
                // ),
                user['location'] != null
                    ? buildContainerForPRoileData(
                        title: "Location",
                        subtitle: user['location'],
                      )
                    : Container(),
                user['birth_date'] != null
                    ? buildContainerForPRoileData(
                        title: "Birthdate",
                        subtitle: DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(user['birth_date']))
                            .toString(),
                      )
                    : Container(),
                user['gender'] != null
                    ? buildContainerForPRoileData(
                        title: "Gender",
                        subtitle:
                            '${user['gender'][0].toUpperCase()}${user['gender'].substring(1)}',
                      )
                    : Container(),
                (user['height'] != null&&user['height'] != 0  )
                    ? buildContainerForPRoileData(
                        title: "Height",
                        subtitle: "${user['height']} cm",
                      )
                    : Container(),
                (user['weight'] != null&& user['weight'] != 0)
                    ? buildContainerForPRoileData(
                        title: "Weight",
                        subtitle: "${user['weight']} KG",
                        last: true)
                    : Container(),
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
                        bg: Colors.white.withOpacity(0.8),
                        color: kprimary,
                        icon: Icon(
                          Icons.edit,
                          color: kprimary,
                        ),
                        label: "Edit",
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
          )),
    );
  }

  Widget buildContainerForPRoileData(
      {title, subtitle, last = false, first = false}) {
    return Container(

      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 1.5),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: first
              ? BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))
              : last
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))
                  : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:[
     Text(
          title,
          style: TextStyle(
              color: kprimary, fontSize: 18, fontWeight: FontWeight.w900),
        ),
        Text(
          subtitle,
          style: TextStyle(
              color: kprimary, fontSize: 16, fontWeight: FontWeight.w300),
        ),
        ]),
    );
  }
}
