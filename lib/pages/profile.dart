import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/config.dart';
import 'package:flutter_test_app/pages/edit_profile.dart';
import 'package:flutter_test_app/widgets/custum.dart';

class ProfileScrean extends StatefulWidget {
  @override
  _ProfileScreanState createState() => _ProfileScreanState();
}

class _ProfileScreanState extends State<ProfileScrean> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildAppBarForPages(context, "Profile", showProfile: false),
                Container(
                    width: 160,
                    height: 160,
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
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    )),
                SizedBox(height: 15),
                Text('Elon Mask',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        color: kprimary,
                        fontWeight: FontWeight.w900)),
                Text('@mohaed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: ksecondary,
                        fontWeight: FontWeight.w900)),
                SizedBox(height: 20),
                buildContainerForPRoileData(
                    title: "Name", subtitle: "Mohamed Saeed", first: true),
                buildContainerForPRoileData(
                  title: "Email",
                  subtitle: "MohamedSaeed@gmail.com",
                ),
                buildContainerForPRoileData(
                  title: "Location",
                  subtitle: "Egypt,MinyaAlQamh",
                ),
                buildContainerForPRoileData(
                  title: "Birthdate",
                  subtitle: "dd/mm/yyyy",
                ),
                buildContainerForPRoileData(
                  title: "Gender",
                  subtitle: "Male",
                ),
                buildContainerForPRoileData(
                    title: "Weight", subtitle: "80 KG", last: true),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 55,
                      child: buildIconElevatedButton(
                        bg: Colors.white.withOpacity(0.8),
                        color: kprimary,
                        icon: Icon(
                          Icons.edit,
                          color: kprimary,
                        ),
                        label: "Edit",
                        onpressed: () {
                          GoTo(context, EditProfileScrean());
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
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 1.5),
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
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: kprimary, fontSize: 20, fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              color: kprimary, fontSize: 18, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
